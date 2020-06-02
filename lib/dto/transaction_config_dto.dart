import 'package:equatable/equatable.dart';

import 'bank_dto.dart';
import 'transaction_dto.dart';

class TransactionConfigDTO extends Equatable {
  final List<int> suggests;
  final int suggestInputColumn;
  final List<String> payments;
  final int vipFee;
  final int vipDays;
  final List<TransactionDTO> lastTransactions;
  final BankDTO depositBank;
  final int rate;

  TransactionConfigDTO({
    this.suggests,
    this.payments,
    this.vipFee,
    this.vipDays,
    this.lastTransactions,
    this.depositBank,
    this.suggestInputColumn,
    this.rate,
  });

  @override
  List<Object> get props => [
        suggests,
        payments,
        vipFee,
        vipDays,
        lastTransactions,
        depositBank,
        suggestInputColumn,
        rate,
      ];

  static TransactionConfigDTO fromJson(dynamic json) {
    return json == null
        ? null
        : TransactionConfigDTO(
            suggests: List<int>.from(json['suggest']?.map((e) => e == null ? null : e)).toList(),
            vipFee: json['vip_fee'],
            vipDays: json['vip_days'],
            lastTransactions: List<TransactionDTO>.from(
                json['transactions']?.map((e) => e == null ? null : TransactionDTO.fromJson(e))).toList(),
            depositBank: BankDTO.fromJson(json['bank']),
            suggestInputColumn: json['suggest_columns'],
            rate: json['rate'],
          );
  }
}
