import 'item_dto.dart';

class HotItemsDTO {
  final String title;
  final String route;
  final List<ItemDTO> list;

  HotItemsDTO({this.title, this.route, this.list});
}