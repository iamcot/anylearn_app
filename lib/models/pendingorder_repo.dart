import 'package:anylearn/services/config_services.dart';

import '../dto/pending_order_dto.dart';
import 'package:http/http.dart' as http;

import '../services/pendingorder_service.dart';

class PendingorderRepository {
  late PendingorderService pendingOrderService;
  final config;
  final httpClient = http.Client();


  PendingorderRepository({this.config}) {
    pendingOrderService =
        PendingorderService(config: config, httpClient: httpClient);
  }
  Future<PendingOrderDTO> dataPendingOrderPage(int id ,int userId) async {
    return await pendingOrderService.PendingOrderConfigs(id , userId);
  }
//  Future<Map<String, List<PendingorderDTO>>> dataupdatePage(String token) async {
//     return await pendingOrderService.history(token);
//   }
}
