import 'package:equatable/equatable.dart';

import 'users_paging_dto.dart';

class UsersDTO extends Equatable {
  final String banner;
  final UsersPagingDTO list;

  UsersDTO({this.banner, this.list});

  @override
  List<Object> get props => [banner, list];

  static UsersDTO fromJson(dynamic json) {
    return json == null
        ? null
        : UsersDTO(
            banner: json['banner'],
            list: UsersPagingDTO.fromJson(json['list']),
          );
  }
}
