import '../dto/account_transaction_dto.dart';
import '../dto/transaction_config_dto.dart';
import '../services/account_services.dart';
import '../services/config_services.dart';

class TransactionRepository {
  final configService = ConfigServices();
  final accountService = AccountServices();

  Future<TransactionConfigDTO> dataTransactionPage(String type, int userId) async {
    return configService.transactionConfigs(type, userId);
  }

  Future<Map<String, AccountTransactionDTO>> dataHistoryPage(int userId) async {
    return accountService.transactionHistory(userId);
  }
}
