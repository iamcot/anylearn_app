import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../dto/foundation_dto.dart';
import '../../dto/transaction_config_dto.dart';
import '../../dto/transaction_dto.dart';

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
  final Map<String, List<TransactionDTO>> history;

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

class FoundationLoadingState extends TransactionState {}

class FoundationSuccessState extends TransactionState {
  final FoundationDTO value;

  FoundationSuccessState({this.value});
  @override
  List<Object> get props => [value];
}

class TransactionDepositavingState extends TransactionState {}

class TransactionDepositeSaveSuccessState extends TransactionState {
  // final TransactionConfigDTO configs;

  // TransactionDepositeSaveSuccessState({this.configs});
  // @override
  // List<Object> get props => [configs];
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
