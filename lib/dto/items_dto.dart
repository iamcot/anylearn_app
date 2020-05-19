import 'package:anylearn/dto/item_dto.dart';
import 'package:anylearn/dto/user_dto.dart';

class ItemsDTO {
  final UserDTO user;
  final List<ItemDTO> items;

  ItemsDTO({this.user, this.items});
}