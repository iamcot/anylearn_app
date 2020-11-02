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
        final data = await transactionRepository.dataHistoryPage(event.token);
        if (data == null) {
          yield TransactionFailState(error: "Không load lịch sử giao dich.");
        } else {
          yield TransactionHistorySuccessState(history: data);
        }
      } else if (event is LoadFoundationEvent) {
        yield FoundationLoadingState();
        final value = await transactionRepository.foundation();
        yield FoundationSuccessState(value: value);
      }
    } catch (error, t) {
      yield TransactionFailState(error: error.toString());
      print(error);
      print(t);
    }

    try {
      if (event is SaveDepositEvent) {
        final result = await transactionRepository.submitDeposit(event.amount, event.token, event.payment);
        yield TransactionDepositeSaveSuccessState();
      } else if (event is SaveWithdrawEvent) {
        final config = await transactionRepository.submitWithdraw(event.amount, event.token, event.bankInfo);
        yield TransactionWithdrawSaveSuccessState();
      } else if (event is SaveExchangeEvent) {
        final config = await transactionRepository.submitExchange(event.amount, event.token);
        yield TransactionExchangeSaveSuccessState();
      }
    } catch (error, trace) {
      print(error);
      print(trace);
      yield TransactionSaveFailState(error: error.toString());
    }
  }
}
