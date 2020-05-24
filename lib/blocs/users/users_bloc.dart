import 'package:bloc/bloc.dart';

import '../../models/user_repo.dart';
import 'users_event.dart';
import 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserRepository userRepository;
  final String role;
  UsersBloc({this.role, this.userRepository});

  @override
  UsersState get initialState => UsersInitState();

  @override
  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    if (event is LoadList) {
      yield UsersLoadingState();

      try {
        final users = await userRepository.getUserList(this.role);
        if (users != null) {
          yield UsersLoadSuccessState(users: users);
        } else {
          yield UsersLoadFailState(error: "Không có thông tin bạn đang tìm kiếm.");
        }
      } catch (error) {
        yield UsersLoadFailState(error: "Có lỗi xảy ra, vui lòng thử lại.");
      }
    }
  }
}
