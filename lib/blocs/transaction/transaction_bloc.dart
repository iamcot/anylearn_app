import 'package:bloc/bloc.dart';

import '../../dto/const.dart';
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
        final data = await transactionRepository.dataHistoryPage(event.token);
        if (data == null) {
          yield TransactionFailState(error: "Không load lịch sử giao dich.");
        } else {
          yield TransactionHistorySuccessState(history: data);
        }
      } else if (event is SaveDepositEvent) {
        final result = await transactionRepository.submitDeposit(event.amount, event.token, event.payment);
        if (result) {
          yield TransactionDepositeSaveSuccessState();
        } else {
          yield TransactionSaveFailState(error: "Có lỗi xảy ra, vui lòng thử lại");
        }
      } else if (event is SaveWithdrawEvent) {
        final config = await transactionRepository.dataTransactionPage(MyConst.TRANS_TYPE_WITHDRAW, event.token);
        yield TransactionWithdrawSaveSuccessState(configs: config);
      } else if (event is SaveExchangeEvent) {
        final config = await transactionRepository.dataTransactionPage(MyConst.TRANS_TYPE_EXCHANGE, event.token);
        yield TransactionExchangeSaveSuccessState(configs: config);
      } else if (event is LoadFoundationEvent) {
        final value = await transactionRepository.foundation();
        yield FoundationSuccessState(value: value);
      }
    } catch (error, t) {
      yield TransactionFailState(error: "Có lỗi xảy ra, vui lòng thử lại. $error");
      print(t);
    }
  }
}
