import 'package:anylearn/dto/const.dart';
import 'package:bloc/bloc.dart';

import '../../models/transaction_repo.dart';
import 'transaction_blocs.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository transactionRepository;
  TransactionBloc({this.transactionRepository});

  @override
  TransactionState get initialState => TransactionInitState();

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    try {
      if (event is LoadTransactionPageEvent) {
        final config = await transactionRepository.dataTransactionPage(event.type, event.token);
        if (config == null) {
          yield TransactionFailState(error: "Không load được cấu hình.");
        } else {
          yield TransactionConfigSuccessState(configs: config);
        }
      } else if (event is LoadTransactionHistoryEvent) {
        final data = await transactionRepository.dataHistoryPage(event.userId);
        if (data == null) {
          yield TransactionFailState(error: "Không load lịch sử giao dich của ${event.userId}.");
        } else {
          yield TransactionHistorySuccessState(history: data);
        }
      } else if (event is SaveDepositEvent) {
        final config = await transactionRepository.dataTransactionPage(MyConst.TRANS_TYPE_DEPOSIT, event.token);
        yield TransactionDepositeSaveSuccessState(configs: config);
      } else if (event is SaveWithdrawEvent) {
        final config = await transactionRepository.dataTransactionPage(MyConst.TRANS_TYPE_WITHDRAW, event.token);
        yield TransactionWithdrawSaveSuccessState(configs: config);
      } else if (event is SaveExchangeEvent) {
        final config = await transactionRepository.dataTransactionPage(MyConst.TRANS_TYPE_EXCHANGE, event.token);
        yield TransactionExchangeSaveSuccessState(configs: config);
      }
    } catch (error, t) {
      yield TransactionFailState(error: "Có lỗi xảy ra, vui lòng thử lại. $error");
      print(t);
    }
  }
}
