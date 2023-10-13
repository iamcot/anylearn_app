library eventbloc;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../dto/event_dto.dart';
import '../../models/page_repo.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final PageRepository pageRepository;
  EventBloc({required this.pageRepository}) : super(EventInitState()) {
    on<LoadEventEvent>(_onLoadEventEvent);
  }

  void _onLoadEventEvent(LoadEventEvent event, Emitter<EventState> emit) async {
    try {
      emit(EventLoadingState());
      final data = await pageRepository.monthEvent(event.month);
      return emit(EventSuccessState(data: data));
    } catch (error, trace) {
      emit(EventFailState(error: "Có lỗi xảy ra, vui lòng thử lại. $error"));
      print(trace.toString());
    }
  } 

  /*@override
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
  }*/
}
