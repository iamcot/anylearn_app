import 'transaction_dto.dart';

class AccountTransactionDTO {
  static const WALLET_M = "walletm";
  static const WALLET_C = "walletc";
  
  final String wallet;
  final double currentAmount;
  final List<TransactionDTO> transactions;

  AccountTransactionDTO({this.wallet, this.currentAmount, this.transactions});

}