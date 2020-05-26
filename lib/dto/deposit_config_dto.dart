class DepositeConfigDTO {
  final double walletM;
  final double walletC;
  final List<double> suggests;
  final List<String> payments;
  final double vipFee;
  final int vipDays;
  final List<String> lastTransactions;

  DepositeConfigDTO(
      {this.walletM, this.walletC, this.suggests, this.payments, this.vipFee, this.vipDays, this.lastTransactions});
}
