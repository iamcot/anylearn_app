import '../dto/ask_thread_dto.dart';
import '../dto/user_dto.dart';
import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../dto/ask_paging_dto.dart';
import 'base_service.dart';

class AskService extends BaseService {
  final http.Client httpClient;
  final AppConfig config;

  AskService({required this.httpClient,required this.config});

  Future<AskPagingDTO> getList() async {
    final url = buildUrl(appConfig: config, endPoint: "/ask/list");
    final json = await get(httpClient, url);
    return AskPagingDTO.fromJson(json);
  }

  Future<AskThreadDTO> getThread(int askId, String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/ask/" + askId.toString(), token: token);
    final json = await get(httpClient, url);
    return AskThreadDTO.fromJson(json);
  }

  Future<bool> create(int askId, String title, String content, UserDTO userDTO, String type) async {
    final url = buildUrl(appConfig: config, endPoint: "/ask/create/$type", token: userDTO.token);
    final json = await post(httpClient, url, {
      "ask_id": askId.toString(),
      "title": title,
      "content": content,
    });
    return json['result'];
  }

  Future<bool> selectAnswer(int askId, String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/ask/$askId/select", token: token);
    final json = await get(httpClient, url);
    return json['result'];
  }

  Future<bool> vote(int askId, String type, String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/ask/$askId/vote/$type", token: token);
    final json = await get(httpClient, url);
    return json['result'];
  }
}
