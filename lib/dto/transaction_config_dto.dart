import 'transaction_dto.dart';

class TransactionConfigDTO {
  final double walletM;
  final double walletC;
  final List<int> suggests;
  final int suggestInputColumn;
  final List<String> payments;
  final int vipFee;
  final int vipDays;
  final List<TransactionDTO> lastTransactions;
  final double inputAmount;
  final String inputType;
  final BankDTO withdrawBank;
  final BankDTO depositBank;
  final DateTime vipExpired;
  final int rate;

  TransactionConfigDTO({
    this.walletM,
    this.walletC,
    this.suggests,
    this.payments,
    this.vipFee,
    this.vipDays,
    this.lastTransactions,
    this.inputAmount,
    this.inputType,
    this.withdrawBank,
    this.depositBank,
    this.suggestInputColumn,
    this.vipExpired,
    this.rate,
  });
}

class BankDTO {
  final String bankName;
  final String bankNo;
  final String bankBranch;
  final String accountName;

  BankDTO({
    this.bankName,
    this.bankNo,
    this.bankBranch,
    this.accountName,
  });
}
