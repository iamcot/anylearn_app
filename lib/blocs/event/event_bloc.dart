import 'package:bloc/bloc.dart';

import '../../models/page_repo.dart';
import 'event_event.dart';
import 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final PageRepository pageRepository;
  EventBloc({this.pageRepository}) : super(null);

  @override
  EventState get initialState => EventInitState();

  @override
  Stream<EventState> mapEventToState(EventEvent event) async* {
    try {
      if (event is LoadEventEvent) {
        yield EventLoadingState();
        final data = await pageRepository.monthEvent(event.month);
        if (data != null) {
          yield EventSuccessState(data: data);
        } else {
          yield EventFailState(error: "Không có dữ liệu");
        }
      }
    } catch (error, trace) {
      yield EventFailState(error: "Có lỗi xảy ra, vui lòng thử lại. $error");
      print(trace.toString());
    }
  }
}
