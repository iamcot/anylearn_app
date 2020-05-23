import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../models/user_repo.dart';
import 'auth_event.dart';
import 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
    final UserRepository userRepository;

  AuthBloc({@required this.userRepository}) : assert(userRepository != null);

  @override
  AuthState get initialState => AuthInitState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthCheckEvent) {
      final String token = await userRepository.getToken();
      if  (token != null) {
        yield AuthSuccessState(user: await userRepository.getUser(token));
      } else {
        yield AuthFailState();
      }
    }

    if (event is AuthLoggedInEvent) {
      yield AuthInProgressState();
      await userRepository.storeToken(event.user.token);
      yield AuthSuccessState(user: event.user);
    }

    if (event is AuthLoggedOutEvent) {
      yield AuthInProgressState();
      await userRepository.deleteToken();
      yield AuthFailState();
    }
  }
}