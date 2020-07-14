import 'package:equatable/equatable.dart';

import 'hot_items_dto.dart';
import 'item_dto.dart';
import 'user_dto.dart';

class PdpDTO extends Equatable {
  final UserDTO author;
  final ItemDTO item;
  final int numSchedule;
  final HotItemsDTO hotItems;
  bool isFavorite;
  final int commission;

  PdpDTO({this.author, this.item, this.hotItems, this.isFavorite, this.commission, this.numSchedule});

  @override
  List<Object> get props => [author, item, hotItems, isFavorite, commission, numSchedule];

  static PdpDTO fromJson(dynamic json) {
    return json == null
        ? null
        : PdpDTO(
            item: ItemDTO.fromJson(json['item']),
            author: UserDTO.fromJson(json['author']),
            hotItems: HotItemsDTO.fromJson(json['hotItems']),
            commission: json['commission'],
            numSchedule: json['num_schedule'],
          );
  }
}
