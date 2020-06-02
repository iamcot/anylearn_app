import 'package:equatable/equatable.dart';

class BankDTO extends Equatable {
  final String bankName;
  final String bankNo;
  final String bankBranch;
  final String accountName;
  final String content;

  BankDTO({
    this.bankName,
    this.bankNo,
    this.bankBranch,
    this.accountName,
    this.content
  });

  @override
  List<Object> get props => [bankName, bankNo, bankBranch, accountName, content];

  static BankDTO fromJson(dynamic json) {
    return json == null
        ? null
        : BankDTO(
            bankName: json['bank_name'],
            bankNo: json['bank_no'],
            bankBranch: json['bank_branch'],
            accountName: json['account_name'],
            content: json['content'],
          );
  }
}
