library loginbloc;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/user_repo.dart';
import '../auth/auth_bloc.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;

  LoginBloc({required this.userRepository, required this.authBloc}) : super(LoginInitState()) {
    on<LoginButtonPressedEvent>(_onLoginButtonPressedEvent);
  }

  void _onLoginButtonPressedEvent(LoginButtonPressedEvent event, Emitter<LoginState> emit) async {
    emit(LoginInProgressState());
    try {
      final user = await userRepository.authenticated(phone: event.phone, password: event.password);
      authBloc..add(AuthLoggedInEvent(user: user));
      emit(LoginSuccessState());
    } catch (e) {
      return emit(LoginFailState(error: e.toString()));
    }
  }
  //  if (event is LoginFacebookEvent) {
  //     yield LoginFacebookInProgressState();

  //     try {
  //       final user = await userRepository.loginFacebook(data: event.data);
  //       yield LoginFacebookSuccessState();
  //       authBloc..add(AuthLoggedInEvent(user: user));
  //       yield LoginSuccessState();
  //     } catch (error) {
  //       yield LoginFacebookFailState(error: error.toString());
  //     }
  //   }

  //   if (event is LoginAppleEvent) {
  //     yield LoginAppleInProgressState();

  //     try {
  //       final user = await userRepository.loginApple(data: event.data);
  //       yield LoginAppleSuccessState();
  //       authBloc..add(AuthLoggedInEvent(user: user));
  //       yield LoginSuccessState();
  //     } catch (error) {
  //       yield LoginAppleFailState(error: error.toString());
  //     }
  //   }
}
