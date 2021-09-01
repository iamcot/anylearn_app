import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  final String apiUrl;
  final String webUrl;
  final String tokenParam;

  AppConfig({
    this.apiUrl,
    this.tokenParam,
    this.webUrl,
  });

  static Future<AppConfig> forEnv(String env) async {
    env = env ?? 'dev';
    final content = await rootBundle.loadString('assets/config/$env.json');
    final json = jsonDecode(content);
    return AppConfig(
      apiUrl: json['apiUrl'],
      tokenParam: json['tokenParam'],
      webUrl: json['webUrl'],
    );
  }
}
