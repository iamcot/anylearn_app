import 'package:equatable/equatable.dart';

class TransactionDTO extends Equatable {
  final id;
  final userId;
  final type;
  final amount;
  final content;
  final createdDate;
  final status;
  final orderId;
  final payMethod;
  final bankInfo;
  final refUser;
  final refAmount;

  TransactionDTO({
    this.id,
    this.type,
    this.payMethod,
    this.userId,
    this.amount,
    this.content,
    this.createdDate,
    this.status,
    this.orderId,
    this.bankInfo,
    this.refUser,
    this.refAmount,
  });

  @override
  List<Object> get props => [
        id,
        payMethod,
        type,
        userId,
        amount,
        content,
        createdDate,
        status,
        orderId,
        bankInfo,
        refUser,
        refAmount,
      ];

  static TransactionDTO fromJson(dynamic json) {
    return json == ""
        ? TransactionDTO()
        : TransactionDTO(
            amount: json['amount'] ?? 0,
            userId: json['user_id'] ?? 0,
            id: json['id'] ?? "",
            content: json['content'] ?? "",
            createdDate: json['created_at'] ?? "",
            payMethod: json['pay_method'] ?? "",
            bankInfo: "",
            status: json['status'] ?? "",
            orderId: json['order_id'] ?? 0,
            type: json['type'] ?? "",
            refAmount: json['ref_amount'] ?? "",
            refUser: json['ref_user_id'] ?? "",
          );
  }
}
