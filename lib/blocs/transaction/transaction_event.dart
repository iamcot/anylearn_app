part of transactionbloc;

abstract class TransactionEvent {
  const TransactionEvent();
}

class LoadTransactionPageEvent extends TransactionEvent {
  final String type;
  final String token;

  LoadTransactionPageEvent({required this.type, required this.token});

  @override
  String toString() => 'LoadTransactionPageEvent  { type: $type}';
}

class LoadTransactionHistoryEvent extends TransactionEvent {
  final String token;

  LoadTransactionHistoryEvent({required this.token});

  @override
  String toString() => 'LoadTransactionHistoryEvent  {}';
}

class SaveDepositEvent extends TransactionEvent {
  final String token;
  final String amount;
  final String payment;

  SaveDepositEvent({required this.token, required this.amount, this.payment = ""});

  @override
  String toString() => 'SaveDepositEvent  { amount $amount}';
}

class SaveWithdrawEvent extends TransactionEvent {
  final token;
  final amount;
  final BankDTO bankInfo;

  SaveWithdrawEvent({required this.token, required this.amount, required this.bankInfo});

  @override
  String toString() => 'SaveWithdrawEvent  { amount: $amount, bank: $bankInfo}';
}

class SaveExchangeEvent extends TransactionEvent {
  final String token;
  final int amount;

  SaveExchangeEvent({required this.token, required this.amount});
}

class LoadFoundationEvent extends TransactionEvent {
  @override
  String toString() => '  {  LoadFoundationEvent}';
}
