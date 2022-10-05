import 'package:bloc/bloc.dart';

import '../../models/user_repo.dart';
import 'pendingorder_blocs.dart';

class PendingOrderBloc extends Bloc<PendingOrderEvent, PendingOrderState> {
  final UserRepository pendingorderRepository;
  PendingOrderBloc({required this.pendingorderRepository}) : super(PendingOrderInitState());
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
  }
}
