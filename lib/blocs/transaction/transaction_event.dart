import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../dto/transaction_config_dto.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();
}

class LoadTransactionPageEvent extends TransactionEvent {
  final String type;
  final int userId;

  LoadTransactionPageEvent({@required this.type, @required this.userId});

  @override
  List<Object> get props => [type, userId];

  @override
  String toString() => 'LoadTransactionPageEvent  { type: $type, userId: $userId}';
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
  final int userId;
  final String amount;
  final String payment;

  SaveDepositEvent({@required this.userId, @required this.amount, this.payment});

  @override
  List<Object> get props => [userId, amount, payment];

  @override
  String toString() => 'SaveDepositEvent  { userId: $userId, amount $amount}';
}

class SaveWithdrawEvent extends TransactionEvent {
  final int userId;
  final String amount;
  final BankDTO bankInfo;

  SaveWithdrawEvent({@required this.userId, @required this.amount, this.bankInfo});

  @override
  List<Object> get props => [userId, amount, bankInfo];

  @override
  String toString() => 'SaveWithdrawEvent  { userId: $userId, amount: $amount, bank: $bankInfo}';
}


class SaveExchangeEvent extends TransactionEvent {
  final int userId;
  final String amount;

  SaveExchangeEvent({@required this.userId, @required this.amount});

  @override
  List<Object> get props => [userId, amount];

  @override
  String toString() => 'SaveExchangeEvent  { userId: $userId, amount: $amount}';
}
