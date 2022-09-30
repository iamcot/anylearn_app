import 'package:anylearn/services/base_service.dart';
import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../dto/pending_order_dto.dart';

class PendingorderService extends BaseService {
  final http.Client httpClient;
  final AppConfig config;
  PendingorderService({required this.config, required this.httpClient});

  // ignore: non_constant_identifier_names
  Future<PendingOrderDTO> PendingOrderConfigs(int id, int userId) async {
    final url = buildUrl(
      appConfig: config,
      endPoint: "/user/pending-order",
    );
    print(url);
    final json = await get(httpClient, url);
    return PendingOrderDTO.fromJson(json);
  }
}
