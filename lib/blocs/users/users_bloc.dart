library usersbloc;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../dto/users_dto.dart';
import '../../models/page_repo.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final PageRepository pageRepository;
  UsersBloc({required this.pageRepository}) : super(UsersInitState()) {
    on<UsersSchoolLoadEvent>(_onUsersSchoolLoadEvent);
    on<UsersTeacherLoadEvent>(_onUsersTeacherLoadEvent);
  }

  void _onUsersSchoolLoadEvent(UsersSchoolLoadEvent event, Emitter<UsersState> emit) async {
    try {
      emit(UsersLoadingState());
      final data = await pageRepository.dataSchoolsPage(event.page, event.pageSize);
      return emit(UsersSchoolSuccessState(data: data));
    } catch (error, trace) {
      emit(UsersLoadFailState(error: "Có lỗi xảy ra, vui lòng thử lại. $error"));
      print(trace.toString());
    }
  }

  void _onUsersTeacherLoadEvent(UsersTeacherLoadEvent event, Emitter<UsersState> emit) async {
    try {
      emit(UsersLoadingState());
      final data = await pageRepository.dataTeachersPage(event.page, event.pageSize);
      return emit(UsersTeacherSuccessState(data: data));
    } catch (error, trace) {
      emit(UsersLoadFailState(error: "Có lỗi xảy ra, vui lòng thử lại. $error"));
      print(trace.toString());
    }
  }

  /*@override
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
  }*/
}
