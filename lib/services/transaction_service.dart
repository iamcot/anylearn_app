import 'dart:convert';

import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../dto/bank_dto.dart';
import '../dto/const.dart';
import '../dto/foundation_dto.dart';
import '../dto/transaction_dto.dart';
import 'base_service.dart';

class TransactionService extends BaseService {
  final http.Client httpClient;
  final AppConfig config;

  TransactionService({required this.config,required this.httpClient});

  Future<bool> submitDeposit(String amount, String token, String payMethod) async {
    final url = buildUrl(appConfig: config, endPoint: "/transaction/deposit", token: token);
    final json = await post(httpClient, url, {
      'amount': amount,
      'pay_method': payMethod,
    });
    return json['result'];
  }

  Future<bool> submitWithdraw(String amount, String token, BankDTO payInfo) async {
    final url = buildUrl(appConfig: config, endPoint: "/transaction/withdraw", token: token);
    final json = await post(httpClient, url, {
      'amount': amount,
      'pay_info': jsonEncode(payInfo).toString(),
    });
    return json['result'];
  }

  Future<bool> submitExchange(int amount, String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/transaction/exchange", token: token);
    final json = await post(httpClient, url, {
      'amount': amount.toString(),
    });
    return json['result'];
  }

  Future<Map<String, List<TransactionDTO>>> history(String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/transaction/history", token: token);
    final json = await get(httpClient, url);
    return {
      MyConst.WALLET_M:
          List<TransactionDTO>.from(json[MyConst.WALLET_M]?.map((e) => e == null ? null : TransactionDTO.fromJson(e))),
      MyConst.WALLET_C:
          List<TransactionDTO>.from(json[MyConst.WALLET_C]?.map((e) => e == null ? null : TransactionDTO.fromJson(e))),
    };
  }

  Future<bool> register(String token, int itemId, String voucher, int childUser) async {
    final url = buildUrl(
        appConfig: config,
        endPoint: "/transaction/register/$itemId",
        token: token,
        query: "voucher=$voucher&child=$childUser");
    final json = await get(httpClient, url);
    return json['result'];
  }

  Future<FoundationDTO> foundation() async {
    final url = buildUrl(appConfig: config, endPoint: "/foundation");
    final json = await get(httpClient, url);
    return FoundationDTO.fromJson(json);
  }
}
