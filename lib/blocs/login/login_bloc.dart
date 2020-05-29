import 'package:anylearn/blocs/auth/auth_blocs.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/user_repo.dart';
import '../auth/auth_bloc.dart';
import '../auth/auth_event.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;

  LoginBloc({@required this.userRepository, @required this.authBloc})
      : assert(userRepository != null),
        assert(authBloc != null);

  @override
  LoginState get initialState => LoginInitState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressedEvent) {
      yield LoginInProgressState();

      try {
        final user = await userRepository.authenticated(phone: event.phone, password: event.password);
        authBloc..add(AuthLoggedInEvent(user: user));
        yield LoginSuccessState();
        yield LoginInitState();
      } catch (error) {
        yield LoginFailState(error: error.toString());
      }
    }

    if (event is RegisterButtonPressedEvent) {
      yield RegisterInprogressState();
      try {
        final user = await userRepository.register(event.userInput.phone, event.userInput.name,
            event.userInput.password, event.userInput.refcode, event.userInput.role);
        this.add(LoginButtonPressedEvent(phone: user.phone, password: event.userInput.password));
        yield RegisterSuccessState();
        yield RegisterInitState();
      } catch (e) {
        yield RegisterFailState(error: e.toString());
      }
    }
  }
}
