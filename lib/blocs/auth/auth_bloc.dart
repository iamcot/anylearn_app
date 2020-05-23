import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'auth_state.dart';
import 'auth_event.dart';
import '../../models/user_repo.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
    final UserRepository userRepository;

  AuthBloc({@required this.userRepository}) : assert(userRepository != null);

  @override
  AuthState get initialState => AuthInit();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthStarted) {
      final bool hasToken = await userRepository.hasToken();

      if  (hasToken) {
        yield AuthSuccess();
      } else {
        yield AuthFail();
      }
    }

    if (event is AuthLoggedIn) {
      yield AuthInProgress();
      await userRepository.storeToken(event.token);
      yield AuthSuccess();
    }

    if (event is AuthLoggedOut) {
      yield AuthInProgress();
      await userRepository.deleteToken();
      yield AuthFail();
    }
  }
}