import 'dart:convert';
import 'dart:io';

import 'package:anylearn/dto/v3/calendar_dto.dart';
import 'package:anylearn/dto/v3/listing_dto.dart';
import 'package:anylearn/dto/v3/registered_item_dto.dart';
import 'package:anylearn/dto/v3/schedule_dto.dart';
import 'package:anylearn/dto/v3/study_dto.dart';
import 'package:anylearn/dto/v3/partner_dto.dart';
import 'package:anylearn/dto/v3/subtype_dto.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../app_config.dart';
import '../dto/article_dto.dart';
import '../dto/doc_dto.dart';
import '../dto/event_dto.dart';
import '../dto/item_dto.dart';
import '../dto/transaction_config_dto.dart';
import '../dto/user_dto.dart';
import '../dto/v3/home_dto.dart';
import '../dto/v3/search_suggest_dto.dart';
import 'base_service.dart';

class ConfigServices extends BaseService {
  final http.Client httpClient;
  final AppConfig config;

  ConfigServices({required this.config, required this.httpClient});

  Future<List<CategoryPagingDTO>> category(int catId, page, pageSize) async {
    final url = buildUrl(appConfig: config, endPoint: "/config/category/$catId");
    final json = await get(httpClient, url);
    return List<CategoryPagingDTO>.from(json?.map((e) => CategoryPagingDTO.fromJson(e))).toList();
  }

  Future<TransactionConfigDTO> transactionConfigs(String type, String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/config/transaction/$type", token: token);
    final json = await get(httpClient, url);
    return TransactionConfigDTO.fromJson(json);
  }

  Future<DocDTO> doc(String type) async {
    final url = buildUrl(appConfig: config, endPoint: "/doc/$type");
    final json = await get(httpClient, url);
    return DocDTO.fromJson(json);
  }

  Future<Map<DateTime, List<EventDTO>>> monthEvent(DateTime month) async {
    final DateFormat _month = DateFormat("yyyy-MM");
    final url = buildUrl(appConfig: config, endPoint: "/event/${_month.format(month)}");
    final json = await get(httpClient, url);
    return Map<DateTime, List<EventDTO>>.from(
      json?.map(
        (k, v) => new MapEntry(
          DateTime.parse(k),
          v == null
              ? null
              : (v as List)
                  .map(
                    (e) => e == null ? null : EventDTO.fromJson(e),
                  )
                  .toList(),
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
    // final json = await postImageHasContent(url, file, {
    //   "content": content,
    // });
    final json = await post(httpClient, url, {
      "content": content,
    });

    return json == null ? false : json['result'];
  }

  Future<List<UserDTO>> searchUser(String screen, String query) async {
    final url = buildUrl(appConfig: config, endPoint: "/search", query: "t=user&s=$screen&q=$query");
    final json = await get(httpClient, url);
    return List<UserDTO>.from(json?.map((e) => e == null ? null : UserDTO.fromJson(e))).toList();
  }

  Future<List<ItemDTO>> searchItem(String screen, String query) async {
    final url = buildUrl(appConfig: config, endPoint: "/search", query: "t=item&s=$screen&q=$query");
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

  Future<SearchSuggestDTO> searchSuggestion(String token) async {
    //final json = jsonDecode(await rootBundle.loadString('assets/mock/searchsuggestv3.json'));
    final api  = token == '' ? '/v3/search' : '/v3/auth/search';
    final url = buildUrl(appConfig: config, endPoint: api, token: token);
    final json = await get(httpClient, url);
    return SearchSuggestDTO.fromJson(json);
  }

  Future<HomeV3DTO> homeV3Layout(String token, String role) async {
    //final json = await rootBundle.loadString('assets/mock/homedatav3.json');
    final api = token == '' ? '/v3/home' : '/v3/auth/home';
    final url = buildUrl(appConfig: config, endPoint: api, token: token);
    final json = await get(httpClient, url);
    return HomeV3DTO.fromJson(json);
  }

  Future<SubtypeDTO> subtypeData(String category, String token) async { 
    //final json = await rootBundle.loadString('assets/mock/subtypek12.json');
    final api = token == '' ? '/v3/main-subtypes/' : '/v3/auth/main-subtypes/';
    final url = buildUrl(appConfig: config, endPoint: api + category, token: token);
    final json = await get(httpClient, url);
    return SubtypeDTO.fromJson(json);
  }

  Future<PartnerDTO> dataPartner(int partnerId) async {
    final url = buildUrl(appConfig: config, endPoint: '/v3/partner/$partnerId');
    final json = await get(httpClient, url);
    print(url);
    return PartnerDTO.fromJson(json);
  }

  Future<ListingDTO> dataListing(String query) async {
    final url = buildUrl(appConfig: config, endPoint: '/v3/listing', query: query);
    final json = await get(httpClient, url);
    print(url);
    return ListingDTO.fromJson(json);
  } 

  Future<bool> imageValidation(String url) async {
    final response = await httpClient.get(Uri.parse(url));
    return response.statusCode == 200 ? true : false;
  }

  Future<StudyDTO> dataStudy(UserDTO account, String token) async {
    // final data = await rootBundle.loadString('assets/mock/study.json');
    final url = buildUrl(
      appConfig: config, 
      endPoint: '/v3/auth/study?', 
      query: 0 == account.isChild ? '' : 'child=${account.id}',
      token: token
    );
    final json = await get(httpClient, url);
    return StudyDTO.fromJson(json);
  }

  Future<CalendarDTO> dataSchedule(String token, String lookupDate, String dateFrom, String dateTo) async {
    final url = buildUrl(
      appConfig: config, 
      endPoint: '/v3/auth/study/lookup',
      query: 'date=$lookupDate&from=$dateFrom&to=$dateTo', 
      token: token
    );
    final json = await get(httpClient, url);
    return CalendarDTO.fromJson(json);
  }

  Future<RegisteredItemDTO> dataRegisteredCourse(String token, int orderItemID) async {
    final url = buildUrl(appConfig: config, endPoint: '/v3/auth/study/$orderItemID', token: token);
    final json = await get(httpClient, url);
    return RegisteredItemDTO.fromJson(json);
  }
}
