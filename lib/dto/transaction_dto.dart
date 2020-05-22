class TransactionDTO {
  final int id;
  final double amount;
  final String content;
  final String createdDate;
  final int status;
  final int orderId;

  TransactionDTO({this.id, this.amount, this.content, this.createdDate, this.status,this.orderId});
}