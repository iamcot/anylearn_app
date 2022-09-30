import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  final String apiUrl;
  final String webUrl;
  final String tokenParam;

  AppConfig({
    required this.apiUrl,
    required this.tokenParam,
    required this.webUrl,
  });

  static Future<AppConfig> forEnv() async {
    final content = await rootBundle.loadString('assets/config/staging.json');
    final json = jsonDecode(content);
    return AppConfig(
      apiUrl: json['apiUrl'],
      tokenParam: json['tokenParam'],
      webUrl: json['webUrl'],
    );
  }
}
