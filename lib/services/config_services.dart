import 'dart:io';

import 'package:anylearn/dto/article_dto.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../app_config.dart';
import '../dto/doc_dto.dart';
import '../dto/event_dto.dart';
import '../dto/home_dto.dart';
import '../dto/item_dto.dart';
import '../dto/transaction_config_dto.dart';
import '../dto/user_dto.dart';
import 'base_service.dart';

class ConfigServices extends BaseService {
  final http.Client httpClient;
  final AppConfig config;
  final DateFormat _month = DateFormat("yyyy-MM");

  ConfigServices({required this.config,required this.httpClient});

  Future<HomeDTO> homeLayout(String role) async {
    final url = buildUrl(appConfig: config, endPoint: "/config/homev2/$role");
    final json = await get(httpClient, url);
    return HomeDTO.fromJson(json);
  }

  Future<List<CategoryPagingDTO>> category(int catId, page, pageSize) async {
    final url = buildUrl(appConfig: config, endPoint: "/config/category/$catId");
    final json = await get(httpClient, url);
    return List<CategoryPagingDTO>.from(json?.map((e) => CategoryPagingDTO.fromJson(e))).toList();
  }

  Future<TransactionConfigDTO> transactionConfigs(String type, String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/config/transaction/$type", token: token);
    print(url);
    final json = await get(httpClient, url);
    return TransactionConfigDTO.fromJson(json);
  }

  Future<DocDTO> doc(String type) async {
    final url = buildUrl(appConfig: config, endPoint: "/doc/$type");
    final json = await get(httpClient, url);
    return DocDTO.fromJson(json);
  }

  Future<Map<DateTime, List<EventDTO>>> monthEvent(DateTime month) async {
    final url = buildUrl(appConfig: config, endPoint: "/event/${_month.format(month)}");
    final json = await get(httpClient, url);
    return Map<DateTime, List<EventDTO>>.from(
            json?.map(
              (k, v) => new MapEntry(
                DateTime.parse(k),
                v == null
                    ? null
                    : (v as List).map(
                          (e) => e == null ? null : EventDTO.fromJson(e),
                        ).toList(),
              ),
            ),
          );
  }

  Future<bool> saveFeedback(String token, String content, File file) async {
    final url = buildUrl(
      appConfig: config,
      endPoint: "/config/feedback",
      token: token,
    );
    final json = await postImageHasContent(url, file, {
      "content": content,
    });

    return json == null ? false : json['result'];
  }

  Future<List<UserDTO>> searchUser(String screen, String query) async {
    final url = buildUrl(appConfig: config, endPoint: "/search", query: "t=user&s=${screen}&q=$query");
    print(url);
    final json = await get(httpClient, url);
    return List<UserDTO>.from(json?.map((e) => e == null ? null : UserDTO.fromJson(e))).toList();
  }

  Future<List<ItemDTO>> searchItem(String screen, String query) async {
    final url = buildUrl(appConfig: config, endPoint: "/search", query: "t=item&s=${screen}&q=$query");
    print(url);
    final json = await get(httpClient, url);
    return List<ItemDTO>.from(json?.map((e) => e == null ? null : ItemDTO.fromJson(e))).toList();
  }

  Future<ArticleHomeDTO> articleIndexPage() async {
    final url = buildUrl(appConfig: config, endPoint: "/article");
    final json = await get(httpClient, url);
    return ArticleHomeDTO.fromJson(json);
  }

  Future<ArticlePagingDTO> articleTypePage(String type, int page) async {
    final url = buildUrl(appConfig: config, endPoint: "/article/cat/$type", query: "page=$page");
    final json = await get(httpClient, url);
    return ArticlePagingDTO.fromJson(json);
  }

  Future<ArticleDTO> article(int id) async {
    final url = buildUrl(appConfig: config, endPoint: "/article/$id");
    final json = await get(httpClient, url);
    return ArticleDTO.fromJson(json);
  }

  Future<List<String>> searchTags() async {
    final url = buildUrl(appConfig: config, endPoint: "/search-tags");
    final json = await get(httpClient, url);
    return json == null ? [] : List<String>.from(json);
  }
}
