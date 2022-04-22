import 'package:equatable/equatable.dart';

import 'item_dto.dart';


class HotItemsDTO extends Equatable {
  final title;
  final route;
  final list;

  HotItemsDTO({this.title, this.route, this.list});

  @override
  List<Object> get props => [title, route, list];

  static HotItemsDTO fromJson(dynamic json) {
    return json == ""
        ? HotItemsDTO()
        : HotItemsDTO(
            title: json['title'],
            list: List<ItemDTO>.from(json['list']?.map((v) => v == null ? null : ItemDTO.fromJson(v))).toList(),
            route: json['route'],
          );
  }
}
