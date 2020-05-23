import 'item_dto.dart';
import 'user_dto.dart';

class ItemsDTO {
  final UserDTO user;
  final List<ItemDTO> items;

  ItemsDTO({this.user, this.items});
}