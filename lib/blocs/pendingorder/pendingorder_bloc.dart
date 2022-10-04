import 'package:anylearn/blocs/pendingorder/pendingorder_blos.dart';
import 'package:anylearn/models/user_repo.dart';
import 'package:bloc/bloc.dart';

import '../course/course_state.dart';

class PendingOrderBloc extends Bloc<PendingOrderEvent, PendingOrderState> {
  final UserRepository pendingorderRepository;
  PendingOrderBloc({required this.pendingorderRepository})
      : super(PendingOrderInitState());
  PendingOrderState get initialState => PendingOrderInitState();
  Stream<PendingOrderState> mapEventToState(PendingOrderEvent event) async* {
    try {
      if (event is LoadPendingorderPageEvent) {
        final config = await pendingorderRepository.dataPendingOrderPage(event.token);
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
