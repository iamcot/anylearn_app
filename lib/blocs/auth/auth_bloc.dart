import 'package:bloc/bloc.dart';

import '../../dto/user_dto.dart';
import '../../models/user_repo.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({required this.userRepository}) : super(AuthInitState());

  @override
  AuthState get initialState => AuthInitState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try {
      if (event is AuthCheckEvent) {
        yield AuthInProgressState();
        final String? token = await userRepository.getToken();
        if (token == "") {
          yield AuthFailState(error: "No token");
        } else {
          bool isFull = event.isFull;
          UserDTO userDTO = await userRepository.getUser(token!, isFull);
          if (userDTO.id <= 0) {
            await userRepository.deleteToken();
            yield AuthTokenFailState();
            yield AuthFailState(error: "Cannot get user info");
          } else {
            yield AuthSuccessState(user: userDTO);
          }
        }
      } else if (event is AuthLoggedInEvent) {
        yield AuthInProgressState();
        await userRepository.storeToken(event.user.token);
        yield AuthSuccessState(user: event.user);
      } else if (event is AuthLoggedOutEvent) {
        yield AuthInProgressState();
        await userRepository.deleteToken();
        await userRepository.logout(event.token);

        yield AuthFailState(error: "Loggout");
      }
    } catch (error) {
      yield AuthFailState(error: error.toString());
    }
    try {
      if (event is AuthContractSaveEvent) {
        final result =
            await userRepository.saveContract(event.token, event.contract);
        if (result) {
          yield AuthContractSuccessState();
        }
      }
    } catch (error) {
      yield AuthContractFailState(error: error.toString());
    }
    try {
      if (event is AuthContractLoadEvent) {
        yield AuthContractInProgressState();
        final contract =
            await userRepository.loadContract(event.token, event.contractId);
        print(contract);
        yield AuthContractLoadSuccessState(contract: contract);
      }
    } catch (error) {
      yield AuthContractLoadFailState(error: error.toString());
    }
    try {
      if (event is AuthContractLoadForSignEvent) {
        yield AuthContractInProgressState();
        final contract =
            await userRepository.loadContract(event.token, event.contractId);
        yield AuthContractLoadForSignSuccessState(contract: contract);
      }
    } catch (error) {
      yield AuthContractLoadFailState(error: error.toString());
    }
    try {
      if (event is AuthContractSignEvent) {
        yield AuthContractSigningState();
        await userRepository.signContract(event.token, event.contractId);
        yield AuthContractSignedSuccessState(image: "");
      }
    } catch (error) {
      yield AuthContractSignedFailState(error: error.toString());
    }
    try {
      if (event is AuthPassOtpEvent) {
        yield AuthPassOtpLoadingState();
        await userRepository.sentOtp(event.phone);
        yield AuthPassOtpSuccessState();
      }
      if (event is AuthPassResetEvent) {
        yield AuthPassResetLoadingState();
        await userRepository.resetOtp( event.phone,event.otp,event.password, event.confirmPassword);
        yield AuthPassResetSuccessState();
      }
    } catch (error) {
      yield AuthPassOtpFailState(error: error.toString());
    }
    try {
      if (event is AuthCheckOtpEvent) {
        yield AuthCheckPhoneOTPLoadingState();
        await userRepository.checkOtp(event.otp , event.phone);
        yield AuthCheckPhoneOTPResetSuccessState();
      }
    } catch (error) {
      yield AuthCheckPhoneOtpFailState(error: error.toString());
    }
  }
}
