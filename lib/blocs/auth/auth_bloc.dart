import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../dto/user_dto.dart';
import '../../models/user_repo.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({@required this.userRepository}) : assert(userRepository != null), super(null);

  @override
  AuthState get initialState => AuthInitState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try {
      if (event is AuthCheckEvent) {
        yield AuthInProgressState();
        final String token = await userRepository.getToken();
        if (token == null) {
          yield AuthFailState();
        } else {
          bool isFull = event.isFull ?? false;
          UserDTO userDTO = await userRepository.getUser(token, isFull);
          if (userDTO == null) {
            await userRepository.deleteToken();
            yield AuthTokenFailState();
            yield AuthFailState();
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
        yield AuthFailState();
      }
    } catch (error) {
      yield AuthFailState(error: error.toString());
    }
    try {
      if (event is AuthContractSaveEvent) {
        final result = await userRepository.saveContract(event.token, event.contract);
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
        final contract = await userRepository.loadContract(event.token, event.contractId);
        yield AuthContractLoadSuccessState(contract: contract);
      }
    } catch (error) {
      yield AuthContractLoadFailState(error: error.toString());
    }
     try {
      if (event is AuthContractLoadForSignEvent) {
        yield AuthContractInProgressState();
        final contract = await userRepository.loadContract(event.token, event.contractId);
        yield AuthContractLoadForSignSuccessState(contract: contract);
      }
    } catch (error) {
      yield AuthContractLoadFailState(error: error.toString());
    }
    try {
      if (event is AuthContractSignEvent) {
        yield AuthContractSigningState();
        await userRepository.signContract(event.token, event.contractId);
        yield AuthContractSignedSuccessState();
      }
    } catch (error) {
      yield AuthContractSignedFailState(error: error.toString());
    }
  }
}
