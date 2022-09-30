import 'package:anylearn/blocs/pendingorder/pendingorder_blos.dart';
import 'package:bloc/bloc.dart';

import '../../models/pendingorder_repo.dart';
import '../course/course_state.dart';

class PendingOrderBloc extends Bloc<PendingOrderEvent, PendingOrderState> {
  final PendingorderRepository pendingorderRepository;
  PendingOrderBloc({required this.pendingorderRepository})
      : super(PendingOrderInitState());
  PendingOrderState get initialState => PendingOrderInitState();
  Stream<PendingOrderState> mapEventToState(PendingOrderEvent event) async* {
    try {
      if (event is LoadPendingorderPageEvent) {
        final config = await pendingorderRepository.dataPendingOrderPage(
            event.id, event.userId);
        if (config == null) {
          yield PendingOrderFailState(error: "Không load được cấu hình.");
        } else {
          yield PendingOrderConfigSuccessState(configs: config);
        }
      }
    } catch (error, trace) {
      print(error);
      print(trace);
      yield PendingOrderFailState(error: error.toString());
    }
  }
}
