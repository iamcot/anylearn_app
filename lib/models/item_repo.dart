import 'dart:io';

import '../dto/user_courses_dto.dart';
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

  Future<UserCoursesDTO> coursesOfUser(String token) async {
    return await itemService.coursesOfUser(token);
  }

  Future<ItemDTO> loadItemEdit(int itemId, String token) async {
    return await itemService.loadItemEdit(itemId, token);
  }

  Future<String> uploadImage(File file, String token, int itemId) async {
    return await itemService.uploadImage(token, file, itemId);
  }

  Future<bool> changeUserStatus(int itemId, int newStatus, String token) async {
    return await itemService.changeUserStatus(itemId, newStatus, token);
  }
}
