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
        if (user != null) {
          authBloc..add(AuthLoggedInEvent(user: user));
          yield LoginSuccessState();
          yield LoginInitState();
        } else {
          yield LoginFailState(error: "Thông tin đăng nhập không đúng.");
        }
      } catch (error) {
        yield LoginFailState(error: "Có lỗi xảy ra, vui lòng thử lại.");
      }
    }
  }
}
