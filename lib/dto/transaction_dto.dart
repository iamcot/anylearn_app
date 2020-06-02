import 'package:equatable/equatable.dart';

import 'bank_dto.dart';

class TransactionDTO extends Equatable {
  final int id;
  final int userId;
  final String type;
  final double amount;
  final String content;
  final String createdDate;
  final int status;
  final int orderId;
  final String payMethod;
  final BankDTO bankInfo;

  TransactionDTO(
      {this.id,
      this.type,
      this.payMethod,
      this.userId,
      this.amount,
      this.content,
      this.createdDate,
      this.status,
      this.orderId,
      this.bankInfo});

  @override
  List<Object> get props => [id, payMethod, type, userId, amount, content, createdDate, status, orderId, bankInfo];

  static TransactionDTO fromJson(dynamic json) {
    return json == null
        ? null
        : TransactionDTO(
            amount: json['amount'],
            userId: json['user_id'],
            id: json['id'],
            content: json['content'],
            createdDate: json['created_at'],
            payMethod: json['pay_method'],
            bankInfo: BankDTO.fromJson(json['pay_info']),
            status: json['status'],
            orderId: json['order_id'],
            type: json['type'],
          );
  }
}
