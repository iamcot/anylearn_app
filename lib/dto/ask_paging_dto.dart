import 'package:equatable/equatable.dart';

import 'ask_dto.dart';

class AskPagingDTO extends Equatable {
  final currentPage;
  final List<AskDTO> data;
  final from;
  final lastPage;
  final perPage;
  final to;
  final total;

  AskPagingDTO({this.currentPage, this.data, this.from, this.lastPage, this.perPage, this.to, this.total});

  @override
  List<Object> get props => [currentPage, data, from, lastPage, perPage, to, total];

  @override
  String toString() {
    return 'PagingDTO {currentPage: $currentPage, total: $total, perPage: $perPage}';
  }

  static AskPagingDTO fromJson(dynamic json) {
    return json == null
        ? null
        : AskPagingDTO(
            currentPage: json['current_page'],
            data: List<AskDTO>.from(json['data']?.map((v) => v == null ? null : AskDTO.fromJson(v))).toList(),
            from: json['from'],
            to: json['to'],
            perPage: json['per_page'],
            lastPage: json['last_page'],
            total: json['total'],
          );
  }
}
