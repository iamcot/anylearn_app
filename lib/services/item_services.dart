import 'package:anylearn/customs/rest_exception.dart';
import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../dto/item_dto.dart';
import '../dto/items_dto.dart';
import '../dto/pdp_dto.dart';
import '../dto/user_dto.dart';
import 'base_service.dart';

class ItemService extends BaseService {
  final http.Client httpClient;
  final AppConfig config;

  ItemService({this.config, this.httpClient});

  Future<bool> saveItem(ItemDTO item, String token) async {
    if (item == null) {
      throw BadRequestException("Vui lòng nhập liệu");
    }
    final url = buildUrl(
      appConfig: config,
      endPoint: item.id == null ? "/item/create" : "/item/${item.id}/edit",
      token: token,
    );
    print(url);
    final json = await post(httpClient, url, {
      "id": item.id ?? "",
      "type": item.type ?? "",
      "title": item.title ?? "",
      "price": item.price != null ? item.price.toString() : "",
      "org_price": item.priceOrg != null ? item.priceOrg.toString() : "",
      "date_start": item.dateStart,
      "date_end": item.dateEnd ?? "",
      "time_start": item.timeStart,
      "time_end": item.timeEnd ?? "",
      "location": item.location ?? "",
      "short_content": item.shortContent ?? "",
      "content": item.content ?? "",
    });
    return json['result'];
  }

  Future<ItemsDTO> itemsListOfUser(int userId, int page, int pageSize) async {
    return ItemsDTO(
      user: new UserDTO(),
      items: <ItemDTO>[
        new ItemDTO(),
      ],
    );
  }

  Future<PdpDTO> getPDPData(int itemId) async {
    return new PdpDTO(
      hotItems: [],
      author: new UserDTO(),
      item: new ItemDTO(),
    );
  }
}
