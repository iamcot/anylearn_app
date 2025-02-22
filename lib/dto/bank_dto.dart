class BankDTO {
  final bankName;
  final bankNo;
  final bankBranch;
  final accountName;
  final content;

  BankDTO({this.bankName, this.bankNo, this.bankBranch, this.accountName, this.content});

  // @override
  // List<Object> get props => [bankName, bankNo, bankBranch, accountName, content];

  static BankDTO fromJson(dynamic json) {
    return json == ""
        ? BankDTO()
        : BankDTO(
            bankName: json['bank_name'] ?? "",
            bankNo: json['bank_no'] ?? "",
            bankBranch: json['bank_branch'] ?? "",
            accountName: json['account_name'] ?? "",
            content: json['content'] ?? "",
          );
  }

  Map<String, dynamic> toJson() {
    return {
      'bank_name': bankName,
      'bank_no': bankNo,
      'bank_branch': bankBranch,
      'account_name': accountName,
      'content': content
    };
  }
}
