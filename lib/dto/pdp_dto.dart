import 'package:anylearn/dto/hot_items_dto.dart';
import 'package:anylearn/dto/item_dto.dart';
import 'package:anylearn/dto/user_dto.dart';

class PdpDTO {
  final UserDTO user;
  final ItemDTO item;
  final List<HotItemsDTO> hotItems;

  PdpDTO({this.user, this.item, this.hotItems});
}