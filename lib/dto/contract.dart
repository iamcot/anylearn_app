import 'package:equatable/equatable.dart';

class ContractDTO extends Equatable {
  final id;
  int userId;
  final status;
  String type;
  String certId;
  String certPlace;
  String certDate;
  String tax;
  String ref;
  String refTitle;
  String address;
  String commission;
  String bankName;
  String bankBranch;
  String bankNo;
  String bankAccount;
  String signed;
  String template;
  String dob;
  String dobPlace;
  String email;

  ContractDTO({
    this.id,
    this.userId,
    this.status,
    this.type,
    this.certId,
    this.certPlace,
    this.certDate,
    this.tax,
    this.refTitle,
    this.address,
    this.commission,
    this.bankName,
    this.bankBranch,
    this.bankNo,
    this.bankAccount,
    this.signed,
    this.template,
    this.ref,
    this.dob,
    this.dobPlace,
    this.email,
  });

  @override
  List<Object> get props => [];

  static ContractDTO fromJson(dynamic json) {
    return json == null
        ? null
        : ContractDTO(
            id: json['id'],
            userId: json['user_id'],
            status: json['status'],
            type: json['type'],
            certId: json['cert_id'],
            certDate: json['cert_date'],
            certPlace: json['cert_place'],
            tax: json['tax'],
            refTitle: json['ref_title'],
            address: json['address'],
            commission: json['commission'].toString(),
            bankName: json['bank_name'],
            bankBranch: json['bank_branch'],
            bankNo: json['bank_no'],
            bankAccount: json['bank_account'],
            signed: json['signed'],
            template: json['template'],
            ref: json['ref'],
            dob: json['dob'],
            dobPlace: json['dob_place'],
            email: json['email'],
          );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      // 'user_id': userId,
      // 'status': status,
      // 'type': type,
      'cert_id': certId,
      'cert_date': certDate,
      'cert_place': certPlace,
      'tax': tax,
      'ref_title': refTitle,
      'address': address,
      'commission': commission,
      'bank_name': bankName,
      'bank_no': bankNo,
      'bank_branch': bankBranch,
      'bank_account': bankAccount,
      'dob': dob,
      'dob_place': dobPlace,
      'email': email,
      'ref': ref,
      // 'signed': signed,
    };
  }

  @override
  String toString() =>
      "ContractDTO {id: $id, certId: $certId, certDate: $certDate, certPlace: $certPlace, tax: $tax, commission: $commission, bankName: $bankName}";
}
