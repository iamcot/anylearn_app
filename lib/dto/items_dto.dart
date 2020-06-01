import 'package:equatable/equatable.dart';

import 'items_paging_dto.dart';
import 'user_dto.dart';

class ItemsDTO extends Equatable{
  final UserDTO user;
  final ItemsPagingDTO items;

  ItemsDTO({this.user, this.items});

  @override
  List<Object> get props => [user, items];

  static ItemsDTO fromJson(dynamic json) {
    return json == null ? null : ItemsDTO(
      user: UserDTO.fromJson(json['user']),
      items: ItemsPagingDTO.fromJson(json['items']),
    );
  }
}