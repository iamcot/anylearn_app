import 'package:equatable/equatable.dart';

import 'hot_items_dto.dart';
import 'item_dto.dart';
import 'user_dto.dart';

class PdpDTO extends Equatable{
  final UserDTO author;
  final ItemDTO item;
  final HotItemsDTO hotItems;
  bool isFavorite;

  PdpDTO({this.author, this.item, this.hotItems, this.isFavorite});

  @override
  List<Object> get props =>  [author, item, hotItems, isFavorite];

  static PdpDTO fromJson(dynamic json) {
    return json == null ? null : PdpDTO(
      item: ItemDTO.fromJson(json['item']),
      author: UserDTO.fromJson(json['author']),
      hotItems: HotItemsDTO.fromJson(json['hotItems']),
    );
  }
}