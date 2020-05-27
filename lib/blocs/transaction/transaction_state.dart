import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../dto/account_transaction_dto.dart';
import '../../dto/transaction_config_dto.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();
  @override
  List<Object> get props => [];
}

class TransactionInitState extends TransactionState {}

class TransactionLoadingState extends TransactionState {}

class TransactionConfigSuccessState extends TransactionState {
  final TransactionConfigDTO configs;
  const TransactionConfigSuccessState({this.configs});
  @override
  List<Object> get props => [configs];
}

class TransactionHistoryLoadingState extends TransactionState {}

class TransactionHistorySuccessState extends TransactionState {
  final Map<String, AccountTransactionDTO> history;

  TransactionHistorySuccessState({this.history});
  @override
  List<Object> get props => [history];
}

class TransactionWithdrawSavingState extends TransactionState {}

class TransactionWithdrawSaveSuccessState extends TransactionState {
  final TransactionConfigDTO configs;

  TransactionWithdrawSaveSuccessState({this.configs});
  @override
  List<Object> get props => [configs];
}

class TransactionDepositavingState extends TransactionState {}

class TransactionDepositeSaveSuccessState extends TransactionState {
  final TransactionConfigDTO configs;

  TransactionDepositeSaveSuccessState({this.configs});
  @override
  List<Object> get props => [configs];
}

class TransactionExchangeSavingState extends TransactionState {}

class TransactionExchangeSaveSuccessState extends TransactionState {
  final TransactionConfigDTO configs;

  TransactionExchangeSaveSuccessState({this.configs});
  @override
  List<Object> get props => [configs];
}

class TransactionSaveFailState extends TransactionState {
  final String error;
  const TransactionSaveFailState({@required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}

class TransactionFailState extends TransactionState {
  final String error;
  const TransactionFailState({@required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}
