import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../app_config.dart';
import '../dto/doc_dto.dart';
import '../dto/event_dto.dart';
import '../dto/home_dto.dart';
import '../dto/transaction_config_dto.dart';
import 'base_service.dart';

class ConfigServices extends BaseService {
  final http.Client httpClient;
  final AppConfig config;
  final DateFormat _month = DateFormat("yyyy-MM");

  ConfigServices({this.config, this.httpClient});

  Future<HomeDTO> homeLayout(String role) async {
    final url = buildUrl(appConfig: config, endPoint: "/config/home/$role");
    final json = await get(httpClient, url);
    return HomeDTO.fromJson(json);
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
    final url = buildUrl(appConfig: config, endPoint: "/event/${_month.format(month)}");
    final json = await get(httpClient, url);
    return json == null || json.length == 0
        ? null
        : Map<DateTime, List<EventDTO>>.from(
            json?.map(
              (k, v) => new MapEntry(
                DateTime.parse(k),
                v == null
                    ? null
                    : (v as List)
                        ?.map(
                          (e) => e == null ? null : EventDTO.fromJson(e),
                        )
                        ?.toList(),
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
      "content": content ?? "",
    });
    
    return json == null ? false : json['result'];
  }
}
