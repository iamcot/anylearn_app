import 'package:equatable/equatable.dart';

import 'item_dto.dart';

class ItemsPagingDTO extends Equatable {
  final currentPage;
  final List<ItemDTO> data;
  final from;
  final lastPage;
  final perPage;
  final to;
  final total;

  ItemsPagingDTO({this.currentPage, this.data, this.from, this.lastPage, this.perPage, this.to, this.total});

  @override
  List<Object> get props => [currentPage, data, from, lastPage, perPage, to, total];

  @override
  String toString() {
    return 'PagingDTO {currentPage: $currentPage, total: $total, perPage: $perPage}';
  }

  static ItemsPagingDTO fromJson(dynamic json) {
    return json == null
        ? null
        : ItemsPagingDTO(
            currentPage: json['current_page'],
            data: List<ItemDTO>.from(json['data']?.map((v) => v == null ? null : ItemDTO.fromJson(v))).toList(),
            // from: json['from'],
            // to: json['to'],
            perPage: json['per_page'],
            // lastPage: json['last_page'],
            total: json['total'],
          );
  }
}
