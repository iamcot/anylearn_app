import 'hot_items_dto.dart';
import 'item_dto.dart';
import 'user_dto.dart';

class PdpDTO {
  final UserDTO user;
  final ItemDTO item;
  final List<HotItemsDTO> hotItems;

  PdpDTO({this.user, this.item, this.hotItems});
}