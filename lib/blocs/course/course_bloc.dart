import 'package:bloc/bloc.dart';

import '../../models/item_repo.dart';
import '../../models/user_repo.dart';
import 'course_event.dart';
import 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final ItemRepository itemRepository;
  final UserRepository userRepository;
  CourseBloc({this.userRepository, this.itemRepository});

  @override
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
          yield CourseFailState(error: "Lưu khóa học thất bại, vui lòng thử lại.");
        }
      }

      if (event is ListCourseEvent) {
        yield CourseListLoadingState();
        final result = await itemRepository.coursesOfUser(event.token);
        yield CourseListSuccessState(data: result);
      }

      if (event is CourseUploadImageEvent) {
        yield UploadImageInprogressState();
        String url = await itemRepository.uploadImage(event.image, event.token, event.itemId);
        if (url != null && url.isNotEmpty) {
          yield UploadImageSuccessState(url: url);
        } else {
          yield CourseFailState(error: "Up hình không thành công. Có thể file ảnh không phù hợp. Vui lòng thử lại");
        }
      }

      if (event is CourseChangeUserStatusEvent) {
        yield CourseUserStatusInprogressState();
        await itemRepository.changeUserStatus(event.itemId, event.newStatus, event.token);
        yield CourseUserStatusSuccessState();
      }

      if (event is RegisteredUsersEvent) {
        final users = await userRepository.registeredUsers(event.token, event.itemId);
        yield RegisteredUsersSuccessState(users: users);
      }
    } catch (error, trace) {
      yield CourseFailState(error: error.toString());
      print(trace.toString());
    }
  }
}
