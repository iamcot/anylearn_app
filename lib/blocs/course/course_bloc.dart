library coursebloc;

import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../dto/item_dto.dart';
import '../../dto/class_registered_user.dart';
import '../../dto/item_user_action.dart';
import '../../dto/user_courses_dto.dart';

import '../../models/item_repo.dart';
import '../../models/user_repo.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final ItemRepository itemRepository;
  final UserRepository userRepository;

  CourseBloc({required this.userRepository, required this.itemRepository})
      : super(CourseInitState()) {
    on<LoadCourseEvent>(_onLoadCourseEvent);
    on<SaveCourseEvent>(_onSaveCourseEvent);
    on<ListCourseEvent>(_onListCourseEvent);
    on<CourseUploadImageEvent>(_onCourseUploadImageEvent);
    on<CourseChangeUserStatusEvent>(_onCourseChangeUserStatusEvent);
    on<RegisteredUsersEvent>(_onRegisteredUsersEvent);
    on<ReviewSubmitEvent>(_onReviewSubmitEvent);
    on<ReviewLoadEvent>(_onReviewLoadEvent);
  }

  @override
  Future<void> close() {
    return super.close();
  }

  void _onLoadCourseEvent(LoadCourseEvent event, Emitter<CourseState> emit) async {
    try {
      emit(CourseLoadingState());
      final item = await itemRepository.loadItemEdit(event.id, event.token);
      return emit(CourseLoadSuccess(item: item));

      /*if (item != null) {
        emit(CourseLoadSuccess(item: item));
      } else {
        emit(CourseFailState(error: "Không lấy được không tin"));
      }*/
    } catch (error, trace) {
      emit(CourseFailState(error: error.toString()));
      print(trace.toString());
    }
  }

  void _onSaveCourseEvent(SaveCourseEvent event, Emitter<CourseState> emit) async {
    try {
      emit(CourseSavingState());
      final result = await itemRepository.saveItem(event.item, event.token);
      if (result) {
        emit(CourseSaveSuccessState());
      } else {
        emit(CourseFailState(error: "Lưu khóa học thất bại, vui lòng thử lại."));
      }
    } catch (error, trace) {
      emit(CourseFailState(error: error.toString()));
      print(trace.toString());
    }
  }

  void _onListCourseEvent(ListCourseEvent event, Emitter<CourseState> emit) async {
    try {
      emit(CourseListLoadingState());
      final result = await itemRepository.coursesOfUser(event.token);
      emit(CourseListSuccessState(data: result));
    } catch (error, trace) {
      emit(CourseFailState(error: error.toString()));
      print(trace.toString());
    }
  }

  void _onCourseUploadImageEvent(CourseUploadImageEvent event, Emitter<CourseState> emit) async {
    try {
      emit(UploadImageInprogressState());
      String url = await itemRepository.uploadImage(event.image, event.token, event.itemId);
      if (url.isNotEmpty) {
        emit(UploadImageSuccessState(url: url));
      } else {
        emit(CourseFailState(error:
          "Up hình không thành công. Có thể file ảnh không phù hợp. Vui lòng thử lại"
          )
        );
      }
    } catch (error, trace) {
      emit(CourseFailState(error: error.toString()));
      print(trace.toString());
    }
  }

  void _onCourseChangeUserStatusEvent(CourseChangeUserStatusEvent event, Emitter<CourseState> emit) async {
    try {
      emit(CourseUserStatusInprogressState());
      await itemRepository.changeUserStatus(event.itemId, event.newStatus, event.token);
      emit(CourseUserStatusSuccessState());
    } catch (error, trace) {
      emit(CourseFailState(error: error.toString()));
      print(trace.toString());
    }

  }

  void _onRegisteredUsersEvent(RegisteredUsersEvent event, Emitter<CourseState> emit) async {
    try {
      final users = await userRepository.registeredUsers(event.token, event.itemId);
      emit(RegisteredUsersSuccessState(users: users));
    } catch (error, trace) {
      emit(CourseFailState(error: error.toString()));
      print(trace.toString());
    }
  }

  void _onReviewSubmitEvent(ReviewSubmitEvent event, Emitter<CourseState> emit) async {
    try {
      emit(ReviewSubmitingState());
      final result = await itemRepository.saveRating(
        event.itemId, event.rating, event.comment, event.token);
      emit(ReviewSubmitSuccessState(result: result));
    } catch (error) {
      print(error);
      emit(ReviewSubmitFailState());
    }
  }

  void _onReviewLoadEvent(ReviewLoadEvent event, Emitter<CourseState> emit) async {
      try {
        emit(ReviewLoadingState());
        final data = await itemRepository.loadItemReviews(event.itemId);
        emit(ReviewLoadSuccessState(data: data));
      } catch (error) {
        print(error);
        emit(CourseFailState(error: error.toString()));
      }
    }

  /*@override
  CourseState get initialState => CourseInitState();

  @override
  Stream<CourseState> mapEventToState(CourseEvent event) async* {
    try {
      if (event is LoadCourseEvent) {
        yield CourseLoadingState();
        final item = await itemRepository.loadItemEdit(event.id, event.token);
        if (item != null) {
          yield CourseLoadSuccess(item: item);
        } else {
          yield CourseFailState(error: "Không lấy được không tin");
        }
      }
      if (event is SaveCourseEvent) {
        yield CourseSavingState();
        final result = await itemRepository.saveItem(event.item, event.token);
        if (result) {
          yield CourseSaveSuccessState();
        } else {
          yield CourseFailState(
              error: "Lưu khóa học thất bại, vui lòng thử lại.");
        }
      }

      if (event is ListCourseEvent) {
        yield CourseListLoadingState();
        final result = await itemRepository.coursesOfUser(event.token);
        yield CourseListSuccessState(data: result);
      }

      if (event is CourseUploadImageEvent) {
        yield UploadImageInprogressState();
        String url = await itemRepository.uploadImage(
            event.image, event.token, event.itemId);
        if (url != null && url.isNotEmpty) {
          yield UploadImageSuccessState(url: url);
        } else {
          yield CourseFailState(
              error:
                  "Up hình không thành công. Có thể file ảnh không phù hợp. Vui lòng thử lại");
        }
      }

      if (event is CourseChangeUserStatusEvent) {
        yield CourseUserStatusInprogressState();
        await itemRepository.changeUserStatus(
            event.itemId, event.newStatus, event.token);
        yield CourseUserStatusSuccessState();
      }

      if (event is RegisteredUsersEvent) {
        final users =
            await userRepository.registeredUsers(event.token, event.itemId);
        yield RegisteredUsersSuccessState(users: users);
      }
    } catch (error, trace) {
      yield CourseFailState(error: error.toString());
      print(trace.toString());
    }
    if (event is ReviewSubmitEvent) {
      try {
        yield ReviewSubmitingState();
        final result = await itemRepository.saveRating(
            event.itemId, event.rating, event.comment, event.token);
        yield ReviewSubmitSuccessState(result: result);
      } catch (e) {
        print(e);
        yield ReviewSubmitFailState();
      }
    }
    if (event is ReviewLoadEvent) {
      try {
        yield ReviewLoadingState();
        final data = await itemRepository.loadItemReviews(event.itemId);
        yield ReviewLoadSuccessState(data: data);
      } catch (e) {
        print(e);
        yield CourseFailState(error: e.toString());
      }
    }
  }*/
}
