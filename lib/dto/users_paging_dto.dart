import 'package:equatable/equatable.dart';

import 'user_dto.dart';

class UsersPagingDTO extends Equatable {
  final currentPage;
  final data;
  final from;
  final lastPage;
  final perPage;
  final to;
  final int total;

  UsersPagingDTO({this.currentPage, this.data, this.from, this.lastPage, this.perPage, this.to, this.total = 0});

  @override
  List<Object> get props => [currentPage, data, from, lastPage, perPage, to, total];

  @override
  String toString() {
    return 'PagingDTO {currentPage: $currentPage, total: $total, perPage: $perPage}';
  }

  static UsersPagingDTO fromJson(dynamic json) {
    return json == ""
        ? UsersPagingDTO()
        : UsersPagingDTO(
            currentPage: json['current_page'],
            data: json['data'] == null ? [] : List<UserDTO>.from(json['data']?.map((v) => v == null ? null : UserDTO.fromJson(v))).toList(),
            // from: json['from'],
            // to: json['to'],
            perPage: json['per_page'],
            // lastPage: json['last_page'],
            total: json['total'],
          );
  }
}
