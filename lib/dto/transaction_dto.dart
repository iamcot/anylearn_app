import 'package:equatable/equatable.dart';

import 'bank_dto.dart';

class TransactionDTO extends Equatable {
  final int id;
  final int userId;
  final String type;
  final int amount;
  final String content;
  final String createdDate;
  final int status;
  final int orderId;
  final String payMethod;
  final BankDTO bankInfo;
  final int refUser;
  final int refAmount;

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
    return json == null
        ? null
        : TransactionDTO(
            amount: json['amount'],
            userId: json['user_id'],
            id: json['id'],
            content: json['content'],
            createdDate: json['created_at'],
            payMethod: json['pay_method'],
            bankInfo: json['pay_info'].length == 0 ? null : BankDTO.fromJson(json['pay_info']),
            status: json['status'],
            orderId: json['order_id'],
            type: json['type'],
            refAmount: json['ref_amount'],
            refUser: json['ref_user_id'],
          );
  }
}
