import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../dto/bank_dto.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();
}

class LoadTransactionPageEvent extends TransactionEvent {
  final String type;
  final String token;

  LoadTransactionPageEvent({@required this.type, @required this.token});

  @override
  List<Object> get props => [type, token];

  @override
  String toString() => 'LoadTransactionPageEvent  { type: $type}';
}

class LoadTransactionHistoryEvent extends TransactionEvent {
  final String token;

  LoadTransactionHistoryEvent({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoadTransactionHistoryEvent  {}';
}

class SaveDepositEvent extends TransactionEvent {
  final String token;
  final String amount;
  final String payment;

  SaveDepositEvent({@required this.token, @required this.amount, this.payment});

  @override
  List<Object> get props => [token, amount, payment];

  @override
  String toString() => 'SaveDepositEvent  { amount $amount}';
}

class SaveWithdrawEvent extends TransactionEvent {
  final token;
  final amount;
  final BankDTO bankInfo;

  SaveWithdrawEvent({@required this.token, @required this.amount, this.bankInfo});

  @override
  List<Object> get props => [token, amount, bankInfo];

  @override
  String toString() => 'SaveWithdrawEvent  { amount: $amount, bank: $bankInfo}';
}

class SaveExchangeEvent extends TransactionEvent {
  final String token;
  final int amount;

  SaveExchangeEvent({@required this.token, @required this.amount});

  @override
  List<Object> get props => [token, amount];

  @override
  String toString() => 'SaveExchangeEvent  {  amount: $amount}';
}

class LoadFoundationEvent extends TransactionEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => '  {  LoadFoundationEvent}';
}
