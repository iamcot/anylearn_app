import 'package:bloc/bloc.dart';

import '../../models/page_repo.dart';
import 'items_event.dart';
import 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final PageRepository pageRepository;
  ItemsBloc({this.pageRepository});

  @override
  ItemsState get initialState => ItemsInitState();

  @override
  Stream<ItemsState> mapEventToState(ItemsEvent event) async* {
    try {
      yield ItemsLoadingState();
      var data;
      if (event is ItemsSchoolLoadEvent) {
        data = await pageRepository.dataSchoolPage(event.id, event.page, event.pageSize);
        if (data != null) {
          yield ItemsSchoolSuccessState(data: data);
        }
      } else if (event is ItemsTeacherLoadEvent) {
        data = await pageRepository.dataTeacherPage(event.id, event.page, event.pageSize);
        if (data != null) {
          yield ItemsTeacherSuccessState(data: data);
        }
      }
      if (data == null) {
        yield ItemsLoadFailState(error: "Không có thông tin bạn đang tìm kiếm.");
      }
    } catch (error, trace) {
      yield ItemsLoadFailState(error: "Có lỗi xảy ra, vui lòng thử lại. $error");
      print(trace);
    }
  }
}
