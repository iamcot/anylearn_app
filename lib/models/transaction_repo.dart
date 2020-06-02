import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../dto/account_transaction_dto.dart';
import '../dto/transaction_config_dto.dart';
import '../services/account_services.dart';
import '../services/config_services.dart';

class TransactionRepository {
  final AppConfig config;
  ConfigServices configService;
  final accountService = AccountServices();
  final httpClient = http.Client();

  TransactionRepository({this.config}) {
    configService = ConfigServices(config: config, httpClient: httpClient);
  }

  Future<TransactionConfigDTO> dataTransactionPage(String type, String token) async {
    return configService.transactionConfigs(type, token);
  }

  Future<Map<String, AccountTransactionDTO>> dataHistoryPage(int userId) async {
    return accountService.transactionHistory(userId);
  }
}
