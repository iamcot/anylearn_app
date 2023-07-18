library pendingorderbloc;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../dto/pending_order_dto.dart';
import '../../models/user_repo.dart';

part 'pendingorder_event.dart';
part 'pendingorder_state.dart';

class PendingOrderBloc extends Bloc<PendingOrderEvent, PendingOrderState> {
  final UserRepository pendingorderRepository;
  PendingOrderBloc({required this.pendingorderRepository}) : super(PendingOrderInitState()) {
    on<LoadPendingorderPageEvent>(_onLoadPendingOrderPageEvent);
  }

  void _onLoadPendingOrderPageEvent(LoadPendingorderPageEvent event, Emitter<PendingOrderState> emit) async {
    try {
      final config = await pendingorderRepository.dataPendingOrderPage(event.token);
      emit(PendingOrderConfigSuccessState(configs: config));
    } catch (error, trace) {
      print(error);
      print(trace);
      emit(PendingOrderFailState(error: error.toString()));
    }
  }
  /*
  PendingOrderState get initialState => PendingOrderInitState();
  Stream<PendingOrderState> mapEventToState(PendingOrderEvent event) async* {
    try {
      if (event is LoadPendingorderPageEvent) {
        final config = await pendingorderRepository.dataPendingOrderPage(event.token);
        yield PendingOrderConfigSuccessState(configs: config);
      }
    } catch (error, trace) {
      print(error);
      print(trace);
      yield PendingOrderFailState(error: error.toString());
    }
  }*/
}
