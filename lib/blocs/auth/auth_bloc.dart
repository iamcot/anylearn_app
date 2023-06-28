library authbloc;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../dto/user_dto.dart';
import '../../models/user_repo.dart';
import '../../dto/contract.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({required UserRepository userRepository})
      : userRepository = userRepository,
        super(AuthInitState()) {
    on<AuthCheckEvent>(_onAuthCheckEvent);
    on<AuthLoggedInEvent>(_onAuthLoggedInEvent);
    on<AuthLoggedOutEvent>(_onAuthLoggedOutEvent);
    on<AuthDeleteEvent>(_onAuthDeleteEvent);
  }

  @override
  Future<void> close() {
    return super.close();
  }

  void _onAuthCheckEvent(AuthCheckEvent event, Emitter<AuthState> emit) async {
    try {
      final String? token = await userRepository.getToken();
      if (token == "") {
        return emit(
          AuthFailState(error: "NO TOKEN"),
        );
      } else {
        bool isFull = event.isFull;
        UserDTO userDTO = await userRepository.getUser(token!, isFull);
        if (userDTO.id <= 0) {
          await userRepository.deleteToken();
          return emit(
            AuthFailState(error: "Cannot get user info"),
          );
        } else {
          return emit(
            AuthSuccessState(user: userDTO),
          );
        }
      }
    } catch (e) {
      return emit(AuthFailState(error: e.toString()));
    }
  }

  void _onAuthLoggedInEvent(AuthLoggedInEvent event, Emitter<AuthState> emit) async {
    try {
      await userRepository.storeToken(event.user.token);
      return emit(AuthSuccessState(user: event.user));
    } catch (e) {
      return emit(AuthFailState(error: e.toString()));
    }
  }

  void _onAuthLoggedOutEvent(AuthLoggedOutEvent event, Emitter<AuthState> emit) async {
    try {
      await userRepository.deleteToken();
      await userRepository.logout(event.token);
      return emit(AuthFailState(error: "Loggout"));
    } on Exception catch (e) {
      return emit(AuthFailState(error: e.toString()));
    }
  }

  void _onAuthDeleteEvent(AuthDeleteEvent event, Emitter<AuthState> emit) async {
    try {
      await userRepository.deleteAccount(event.token);
      return emit(AuthDeleteSuccessState());
    } on Exception catch (e) {
      return emit(AuthDeleteFailState(error: e.toString()));
    }
  }

  // void _onAuthLoggedOutEvent(
  //   AuthLoggedOutEvent event,
  //   Emitter<AuthState> emit,
  // ) async {}

  //   try {
  //     if (event is AuthContractSaveEvent) {
  //       final result = await userRepository.saveContract(event.token, event.contract);
  //       if (result) {
  //         yield AuthContractSuccessState();
  //       }
  //     }
  //   } catch (error) {
  //     yield AuthContractFailState(error: error.toString());
  //   }
  //   try {
  //     if (event is AuthContractLoadEvent) {
  //       yield AuthContractInProgressState();
  //       final contract = await userRepository.loadContract(event.token, event.contractId);
  //       print(contract);
  //       yield AuthContractLoadSuccessState(contract: contract);
  //     }
  //   } catch (error) {
  //     yield AuthContractLoadFailState(error: error.toString());
  //   }
  //   try {
  //     if (event is AuthContractLoadForSignEvent) {
  //       yield AuthContractInProgressState();
  //       final contract = await userRepository.loadContract(event.token, event.contractId);
  //       yield AuthContractLoadForSignSuccessState(contract: contract);
  //     }
  //   } catch (error) {
  //     yield AuthContractLoadFailState(error: error.toString());
  //   }
  //   try {
  //     if (event is AuthContractSignEvent) {
  //       yield AuthContractSigningState();
  //       await userRepository.signContract(event.token, event.contractId);
  //       yield AuthContractSignedSuccessState(image: "");
  //     }
  //   } catch (error) {
  //     yield AuthContractSignedFailState(error: error.toString());
  //   }
  //   try {
  //     if (event is AuthPassOtpEvent) {
  //       yield AuthPassOtpLoadingState();
  //       await userRepository.sentOtp(event.phone);
  //       yield AuthPassOtpSuccessState();
  //     }
  //     if (event is AuthResentOtpEvent) {
  //       yield AuthResentOtpLoadingState();
  //       await userRepository.ResentOtp(event.phone);
  //       yield AuthResentOtpSuccessState();
  //     }

  //     if (event is AuthPassResetEvent) {
  //       yield AuthPassResetLoadingState();
  //       await userRepository.resetOtp(event.phone, event.otp, event.password, event.confirmPassword);
  //       yield AuthPassResetSuccessState();
  //     }
  //   } catch (error) {
  //     yield AuthPassOtpFailState(error: error.toString());
  //   }
  //   try {
  //     if (event is AuthCheckOtpEvent) {
  //       yield AuthCheckPhoneOTPLoadingState();
  //       await userRepository.checkOtp(event.otp, event.phone);
  //       yield AuthCheckPhoneOTPResetSuccessState();
  //     }
  //   } catch (error) {
  //     yield AuthCheckPhoneOtpFailState(error: error.toString());
  //   }
  // }
}
