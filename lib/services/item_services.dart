import 'dart:io';

import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../customs/rest_exception.dart';
import '../dto/item_dto.dart';
import '../dto/items_dto.dart';
import '../dto/pdp_dto.dart';
import '../dto/user_courses_dto.dart';
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
    final json = await post(httpClient, url, {
      "id": item.id != null ? item.id.toString() : "",
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

  Future<UserCoursesDTO> coursesOfUser(String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/item/list", token: token);
    print(url);
    final json = await get(httpClient, url);
    return UserCoursesDTO.fromJson(json);
  }

  Future<ItemDTO> loadItemEdit(int itemId, String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/item/$itemId/edit", token: token);
    print(url);
    final json = await get(httpClient, url);
    return ItemDTO.fromJson(json);
  }

  Future<ItemsDTO> itemsListOfUser(int userId, int page, int pageSize) async {
    final url = buildUrl(
        appConfig: config,
        endPoint: "/user/$userId/items",
        query: buildQuery({
          'pageSize': pageSize,
          'page': page,
        }));
    print(url);
    final json = await get(httpClient, url);
    print(json);
    return ItemsDTO.fromJson(json);
  }

  Future<PdpDTO> getPDPData(int itemId) async {
    final url = buildUrl(appConfig: config, endPoint: "/pdp/$itemId");
    print(url);
    final json = await get(httpClient, url);
    return PdpDTO.fromJson(json);
  }

  Future<String> uploadImage(String token, File file, int itemId) async {
    final url = buildUrl(appConfig: config, endPoint: "/item/$itemId/upload-image", token: token);
    print(url);
    final rs = await postImage(url, file);
    return rs;
  }

  Future<bool> changeUserStatus(int itemId, int newStatus, String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/item/$itemId/user-status/$newStatus", token: token);
    print(url);
    final rs = await get(httpClient, url);
    return rs['result'];
  }
}
