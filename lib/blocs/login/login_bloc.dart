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
  LoginState get initialState => LoginInit();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();

      try {
        final token = await userRepository.authenticated(phone: event.phone, password: event.password);
        if (token != null) {
          authBloc.add(AuthLoggedIn(token: token));
          yield LoginSuccess();
          yield LoginInit();
        } else {
          yield LoginFail(error: "Thông tin đăng nhập không đúng.");
        }
      } catch (error) {
        yield LoginFail(error: error.toString());
      }
    }
  }
}
