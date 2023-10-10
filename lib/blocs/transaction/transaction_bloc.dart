library transactionbloc;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../dto/foundation_dto.dart';
import '../../dto/transaction_config_dto.dart';
import '../../dto/transaction_dto.dart';
import '../../dto/bank_dto.dart';
import '../../models/transaction_repo.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository transactionRepository;

  TransactionBloc({required this.transactionRepository}) : super(TransactionInitState()) {
    on<LoadTransactionPageEvent>(_onLoadTransactionPageEvent);
    on<LoadTransactionHistoryEvent>(_onLoadTransactionHistoryEvent);
    on<LoadFoundationEvent>(_onLoadFoundationEvent);
    on<SaveDepositEvent>(_onSaveDepositEvent);
    on<SaveWithdrawEvent>(_onSaveWithdrawEvent);
    on<SaveExchangeEvent>(_onSaveExchangeEvent);
  }

  void _onLoadTransactionPageEvent(LoadTransactionPageEvent event, Emitter<TransactionState> emit) async {
    try {
      final config = await transactionRepository.dataTransactionPage(event.type, event.token);
      if (config == null) {
        emit(TransactionFailState(error: "Không load được cấu hình."));
      } else {
        emit(TransactionConfigSuccessState(configs: config));
      }
    } catch (error, trace) {
      emit(TransactionFailState(error: error.toString()));
      print(error);
      print(trace);
    }
  }

  void _onLoadTransactionHistoryEvent(LoadTransactionHistoryEvent event, Emitter<TransactionState> emit) async {
    try {
      final data = await transactionRepository.dataHistoryPage(event.token);
      if (data == null) {
        emit(TransactionFailState(error: "Không load lịch sử giao dich."));
      } else {
        emit(TransactionHistorySuccessState(history: data));
      }
    } catch (error, trace) {
      emit(TransactionFailState(error: error.toString()));
      print(error);
      print(trace);
    }
  }

  void _onLoadFoundationEvent(LoadFoundationEvent event, Emitter<TransactionState> emit) async {
    try {
      emit(FoundationLoadingState());
      final value = await transactionRepository.foundation();
      emit(FoundationSuccessState(value: value));
    } catch (error, trace) {
      emit(TransactionFailState(error: error.toString()));
      print(error);
      print(trace);
    }
  }

   void _onSaveDepositEvent(SaveDepositEvent event, Emitter<TransactionState> emit) async {
     try {
      await transactionRepository.submitDeposit(event.amount, event.token, event.payment);
      emit(TransactionDepositeSaveSuccessState());
    } catch (error, trace) {
      print(error);
      print(trace);
      emit(TransactionSaveFailState(error: error.toString()));
    }
  }

  void _onSaveWithdrawEvent(SaveWithdrawEvent event, Emitter<TransactionState> emit) async {
    try {
      await transactionRepository.submitWithdraw(event.amount, event.token, event.bankInfo);
      emit(TransactionWithdrawSaveSuccessState());
    } catch (error, trace) {
      print(error);
      print(trace);
      emit(TransactionSaveFailState(error: error.toString()));
    }
  }

  void _onSaveExchangeEvent(SaveExchangeEvent event, Emitter<TransactionState> emit) async {
    try {
      await transactionRepository.submitExchange(event.amount, event.token);
      emit(TransactionExchangeSaveSuccessState());
    } catch (error, trace) {
      print(error);
      print(trace);
      emit(TransactionSaveFailState(error: error.toString()));
    }
  }

  /*@override
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
  }*/
}
