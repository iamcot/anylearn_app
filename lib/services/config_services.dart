import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../dto/home_dto.dart';
import '../dto/transaction_config_dto.dart';
import '../dto/transaction_dto.dart';
import 'base_service.dart';

class ConfigServices extends BaseService {
  final http.Client httpClient;
  final AppConfig config;

  ConfigServices({this.config, this.httpClient});

  Future<HomeDTO> homeLayout(String role) async {
    final url = buildUrl(appConfig: config, endPoint: "/config/home/$role");
    print(url);
    final json = await get(httpClient, url);
    return HomeDTO.fromJson(json);
  }

  Future<TransactionConfigDTO> transactionConfigs(String type, String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/config/transaction/$type", token: token);
    print(url);
    final json = await get(httpClient, url);
    return TransactionConfigDTO.fromJson(json);
  }
}
