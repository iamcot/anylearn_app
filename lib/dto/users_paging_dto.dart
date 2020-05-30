import 'package:equatable/equatable.dart';

import 'user_dto.dart';

class UsersPagingDTO extends Equatable {
  final currentPage;
  final List<UserDTO> data;
  final from;
  final lastPage;
  final perPage;
  final to;
  final total;

  UsersPagingDTO({this.currentPage, this.data, this.from, this.lastPage, this.perPage, this.to, this.total});

  @override
  List<Object> get props => [currentPage, data, from, lastPage, perPage, to, total];

  @override
  String toString() {
    return 'PagingDTO {currentPage: $currentPage, total: $total, perPage: $perPage}';
  }

  static UsersPagingDTO fromJson(dynamic json) {
    return json == null
        ? null
        : UsersPagingDTO(
            currentPage: json['current_page'],
            data: List<UserDTO>.from(json['data']?.map((v) => v == null ? null : UserDTO.fromJson(v))).toList(),
            // from: json['from'],
            // to: json['to'],
            perPage: json['per_page'],
            // lastPage: json['last_page'],
            total: json['total'],
          );
  }
}
