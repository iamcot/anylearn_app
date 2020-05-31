import 'package:bloc/bloc.dart';

import '../../models/item_repo.dart';
import 'course_event.dart';
import 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final ItemRepository itemRepository;
  CourseBloc({this.itemRepository});

  @override
  CourseState get initialState => CourseInitState();

  @override
  Stream<CourseState> mapEventToState(CourseEvent event) async* {
    try {
      if (event is SaveCourseEvent) {
        yield CourseSavingState();
        final result = await itemRepository.saveItem(event.item, event.token);
        if (result) {
          yield CourseSaveSuccessState();
        } else {
          yield CourseFailState(error: "Lưu khóa học thất bại, vui lòng thử lại.");
        }
      }
    } catch (error, trace) {
      yield CourseFailState(error: error.toString());
      // print(trace.toString());
    }
  }
}
