import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  final String apiUrl;
  final String loginEP;
  final String tokenParam;
  final String userInfoEP;

  AppConfig({
    this.apiUrl,
    this.loginEP,
    this.tokenParam,
    this.userInfoEP,
  });

  static Future<AppConfig> forEnv(String env) async {
    env = env ?? 'dev';
    final content = await rootBundle.loadString('assets/config/$env.json');
    final json = jsonDecode(content);
    return AppConfig(
      apiUrl: json['apiUrl'],
      loginEP: json['loginEP'],
      tokenParam: json['tokenParam'],
      userInfoEP: json['userInfoEP'],
    );
  }
}
