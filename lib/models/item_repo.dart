import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../dto/item_dto.dart';
import '../services/item_services.dart';

class ItemRepository {
  ItemService itemService;
  final AppConfig config;
  final httpClient = http.Client();

  ItemRepository({this.config}) {
    itemService = new ItemService(httpClient: httpClient, config: config);
  }

  Future<bool> saveItem(ItemDTO item, String token) async {
    return await itemService.saveItem(item, token);
  }
}
