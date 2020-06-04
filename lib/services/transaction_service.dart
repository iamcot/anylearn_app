import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../dto/bank_dto.dart';
import '../dto/const.dart';
import '../dto/transaction_dto.dart';
import 'base_service.dart';

class TransactionService extends BaseService {
  final http.Client httpClient;
  final AppConfig config;

  TransactionService({this.config, this.httpClient});

  Future<bool> submitDeposit(int amount, String token, String payMethod) async {
    final url = buildUrl(appConfig: config, endPoint: "/transaction/deposit", token: token);
    print(url);
    final json = await post(httpClient, url, {
      'amount': amount.toString(),
      'pay_method': payMethod,
    });
    return json['result'];
  }

  Future<bool> submitWithdraw(int amount, String token, BankDTO payInfo) async {
    final url = buildUrl(appConfig: config, endPoint: "/transaction/withdraw", token: token);
    print(url);
    final json = await post(httpClient, url, {
      'amount': amount.toString(),
      'pay_method': payInfo,
    });
    return json['result'];
  }

  Future<bool> submitXchange(int amount, String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/transaction/xchange", token: token);
    print(url);
    final json = await post(httpClient, url, {
      'amount': amount.toString(),
    });
    return json['result'];
  }

  Future<Map<String, List<TransactionDTO>>> history(String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/transaction/history", token: token);
    print(url);
    final json = await get(httpClient, url);
    print(json);
    return {
      MyConst.WALLET_M:
          List<TransactionDTO>.from(json[MyConst.WALLET_M]?.map((e) => e == null ? null : TransactionDTO.fromJson(e))),
      MyConst.WALLET_C:
          List<TransactionDTO>.from(json[MyConst.WALLET_C]?.map((e) => e == null ? null : TransactionDTO.fromJson(e))),
    };
  }

  Future<bool> register(String token, int itemId) async {
    final url = buildUrl(appConfig: config, endPoint: "/transaction/register/$itemId", token: token);
    print(url);
    final json = await get(httpClient, url);
    return json['result'];
  }

  Future<int> foundation() async {
    final url = buildUrl(appConfig: config, endPoint: "/foundation");
    print(url);
    final json = await get(httpClient, url);
    return json['value'];
  }
}
