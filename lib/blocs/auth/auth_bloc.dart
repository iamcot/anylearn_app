import 'package:anylearn/dto/user_dto.dart';
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
      } else if (event is AuthNotifEvent) {
        yield AuthNotifLoadingState();
        final notifs = await userRepository.notification(event.token);
        yield AuthNotifSuccessState(notif: notifs);
      } else if (event is AuthNotifReadEvent) {
        await userRepository.notifRead(event.token, event.id);
        yield AuthNotifReadState();
      }
    } catch (error) {
      yield AuthFailState(error: error.toString());
    }
  }
}
