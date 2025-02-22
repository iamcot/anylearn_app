import 'package:equatable/equatable.dart';

import 'category_dto.dart';
import 'hot_items_dto.dart';
import 'item_dto.dart';
import 'user_dto.dart';

class PdpDTO extends Equatable {
  final author;
  final item;
  final numSchedule;
  final hotItems;
  bool isFavorite;
  final commission;
  final disableAnypoint;
  final enableIosTrans;
  final categories;

  PdpDTO({this.categories, this.author, this.item, this.hotItems, this.isFavorite = false, this.commission, this.numSchedule, this.enableIosTrans, this.disableAnypoint});

  @override
  List<Object> get props => [author, item, hotItems, isFavorite, commission, numSchedule, enableIosTrans, disableAnypoint, categories];

  static PdpDTO fromJson(dynamic json) {
    return json == ""
        ? PdpDTO()
        : PdpDTO(
            item: ItemDTO.fromJson(json['item']),
            author: UserDTO.fromJson(json['author']),
            hotItems: HotItemsDTO.fromJson(json['hotItems']),
            commission: json['commission'],
            numSchedule: json['num_schedule'],
            isFavorite: json['is_fav'],
            enableIosTrans: json['ios_transaction'] == null ? false : (json['ios_transaction'] == 1),
            disableAnypoint: json['disable_anypoint'] == null ? false : (json['disable_anypoint'] == 1),
            categories: List<CategoryDTO>.from(json['categories']?.map((v) => v == null ? null : CategoryDTO.fromJson(v))).toList(),
          );
  }
}
