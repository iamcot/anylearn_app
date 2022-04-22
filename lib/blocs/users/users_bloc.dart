import 'package:anylearn/blocs/users/users_event.dart';
import 'package:anylearn/blocs/users/users_state.dart';
import 'package:bloc/bloc.dart';

import '../../models/page_repo.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final PageRepository pageRepository;
  UsersBloc({required this.pageRepository}) : super(UsersInitState());

  @override
  UsersState get initialState => UsersInitState();

  @override
  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    try {
      yield UsersLoadingState();
      var data;
      if (event is UsersSchoolLoadEvent) {
        data = await pageRepository.dataSchoolsPage(event.page, event.pageSize);
        if (data != null) {
          yield UsersSchoolSuccessState(data: data);
        }
      } else if (event is UsersTeacherLoadEvent) {
        data = await pageRepository.dataTeachersPage(event.page, event.pageSize);
        if (data != null) {
          yield UsersTeacherSuccessState(data: data);
        }
      }
      if (data == null) {
        yield UsersLoadFailState(error: "Không có thông tin bạn đang tìm kiếm.");
      }
    } catch (error, trace) {
      yield UsersLoadFailState(error: "Có lỗi xảy ra, vui lòng thử lại. $error");
      print(trace.toString());
    }
  }
}
