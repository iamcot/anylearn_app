import 'package:bloc/bloc.dart';

import '../../dto/v3/home_dto.dart';
import '../../models/page_repo.dart';
import 'items_event.dart';
import 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final PageRepository pageRepository;
  ItemsBloc({required this.pageRepository}) : super(ItemsInitState());

  @override
  ItemsState get initialState => ItemsInitState();

  @override
  Stream<ItemsState> mapEventToState(ItemsEvent event) async* {
    try {
      var data;
      if (event is ItemsSchoolLoadEvent) {
        yield ItemsLoadingState();
        data = await pageRepository.dataSchoolPage(event.id, event.page, event.pageSize);
        if (data != null) {
          yield ItemsSchoolSuccessState(data: data);
        }
      } else if (event is ItemsTeacherLoadEvent) {
        yield ItemsLoadingState();
        data = await pageRepository.dataTeacherPage(event.id, event.page, event.pageSize);
        if (data != null) {
          yield ItemsTeacherSuccessState(data: data);
        }
      }
      // if (data == null) {
      //   yield ItemsLoadFailState(error: "Không có thông tin bạn đang tìm kiếm.");
      // }
    } catch (error, trace) {
      yield ItemsLoadFailState(error: "Có lỗi xảy ra, vui lòng thử lại. $error");
      print(trace);
    }
    try {
      if (event is CategoryLoadEvent) {
        yield CategoryLoadingState();
        final List<CategoryPagingDTO> cats = await pageRepository.category(event.id, event.page, event.pageSize);
      }
    } catch (error, trace) {
      yield CategoryFailState(error: "Có lỗi xảy ra, vui lòng thử lại. $error");
      print(error);
    }
  }
}
