import 'package:equatable/equatable.dart';

import 'users_paging_dto.dart';

class UsersDTO extends Equatable {
  final banner;
  final list;

  UsersDTO({this.banner, this.list});

  @override
  List<Object> get props => [banner, list];

  static UsersDTO fromJson(dynamic json) {
    return json == ""
        ? UsersDTO()
        : UsersDTO(
            banner: json['banner'] ?? "",
            list: json['list'] == null ? [] : UsersPagingDTO.fromJson(json['list']),
          );
  }
}
