import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../dto/bank_dto.dart';
import '../dto/transaction_config_dto.dart';
import '../dto/transaction_dto.dart';
import '../services/config_services.dart';
import '../services/transaction_service.dart';

class TransactionRepository {
  final AppConfig config;
  ConfigServices configService;
  TransactionService transactionService;
  final httpClient = http.Client();

  TransactionRepository({this.config}) {
    configService = ConfigServices(config: config, httpClient: httpClient);
    transactionService = TransactionService(config: config, httpClient: httpClient);
  }

  Future<TransactionConfigDTO> dataTransactionPage(String type, String token) async {
    return configService.transactionConfigs(type, token);
  }

  Future<Map<String, List<TransactionDTO>>> dataHistoryPage(String token) async {
    return transactionService.history(token);
  }

  Future<bool> submitDeposit(int amount, String token, String payMethod) async {
    return transactionService.submitDeposit(amount, token, payMethod);
  }

  Future<bool> submitWithdraw(int amount, String token, BankDTO payInfo) async {}
  Future<bool> submitXchange(int amount, String token) async {}

  Future<bool> register(String token, int itemId) async {
    return transactionService.register(token, itemId);
  }

  Future<int> foundation() async {
    return transactionService.foundation();
  }
}
