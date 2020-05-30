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
    final json = await get(url);
    return HomeDTO.fromJson(json);
  }

  Future<TransactionConfigDTO> transactionConfigs(String type, int userId) async {
    return TransactionConfigDTO(
      walletM: 1000,
      walletC: 9999,
      vipFee: 930000,
      vipDays: 30,
      suggests: [930000, 5000000, 2000000, 1000000, 500000, 200000],
      suggestInputColumn: 3,
      payments: [],
      rate: 1000,
      lastTransactions: [
        TransactionDTO(
          content: "Nạp tiền vào ví",
          amount: 930000,
          createdDate: "2020-05-10 09:01:02",
          status: 1,
        ),
        TransactionDTO(
          content: "Nạp tiền vào ví",
          amount: 5000000,
          createdDate: "2020-05-20 09:01:02",
          status: 0,
          bankInfo: BankDTO(
            bankName: "Techcombank",
            bankNo: "123456",
            bankBranch: "CN Q1",
            accountName: "MC Hoài Trinh",
          ),
        ),
      ],
    );
  }
}
