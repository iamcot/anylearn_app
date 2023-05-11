import 'package:equatable/equatable.dart';

class VoucherDTO extends Equatable {
  final title;
  final id;
  final value;

  VoucherDTO({this.title, this.id, this.value});

  @override
  List<Object> get props => [title, id, value];

  static VoucherDTO fromJson(dynamic json) {
    return json == ""
        ? VoucherDTO()
        : VoucherDTO(
            title: json['title'] ?? "",
            id: json['id'] ?? 0,
            value: json['value'] ?? 0.0,
          );
  }
}