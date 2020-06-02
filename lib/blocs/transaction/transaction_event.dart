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
  final int userId;

  LoadTransactionHistoryEvent({@required this.userId});

  @override
  List<Object> get props => [userId];

  @override
  String toString() => 'LoadTransactionHistoryEvent  { userId: $userId}';
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
  final String token;
  final String amount;
  final BankDTO bankInfo;

  SaveWithdrawEvent({@required this.token, @required this.amount, this.bankInfo});

  @override
  List<Object> get props => [token, amount, bankInfo];

  @override
  String toString() => 'SaveWithdrawEvent  { amount: $amount, bank: $bankInfo}';
}

class SaveExchangeEvent extends TransactionEvent {
  final String token;
  final String amount;

  SaveExchangeEvent({@required this.token, @required this.amount});

  @override
  List<Object> get props => [token, amount];

  @override
  String toString() => 'SaveExchangeEvent  {  amount: $amount}';
}
