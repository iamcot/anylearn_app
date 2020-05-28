import 'hot_items_dto.dart';
import 'item_dto.dart';
import 'user_dto.dart';

class PdpDTO {
  final UserDTO author;
  final ItemDTO item;
  final List<HotItemsDTO> hotItems;
  bool isFavorite;

  PdpDTO({this.author, this.item, this.hotItems, this.isFavorite});
}