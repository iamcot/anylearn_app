import 'dart:io';

import 'package:http/http.dart' as http;

import '../dto/item_dto.dart';
import '../dto/item_user_action.dart';
import '../dto/user_courses_dto.dart';
import '../services/item_services.dart';

class ItemRepository {
  late ItemService itemService;
  final config;
  final httpClient = http.Client();

  ItemRepository({required this.config}) {
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

  Future<bool> saveRating(int itemId, int rating, String comment, String token) async {
    return await itemService.saveRating(itemId, rating, comment, token);
  }

  Future<List<ItemUserAction>> loadItemReviews(int itemId) async {
    return await itemService.loadItemReviews(itemId);
  }
}
