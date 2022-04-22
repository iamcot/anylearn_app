import 'package:equatable/equatable.dart';

import 'user_dto.dart';

class HotUsersDTO extends Equatable {
  final title;
  final route;
  final list;

  HotUsersDTO({this.title, this.route, this.list});

  @override
  List<Object> get props => [title, route, list];

  static HotUsersDTO fromJson(dynamic json) {
    return json == ""
        ? HotUsersDTO()
        : HotUsersDTO(
            title: json['title'],
            list: List<UserDTO>.from(json['list']?.map((v) => v == null ? null : UserDTO.fromJson(v))).toList(),
            route: json['route'],
          );
  }
}
