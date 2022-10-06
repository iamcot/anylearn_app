import 'dart:convert';
import 'dart:io';

import 'package:anylearn/main.dart';

import '../app_config.dart';
import 'package:http/http.dart' as http;

import '../customs/rest_exception.dart';

class BaseService {
  String buildUrl(
      {required AppConfig appConfig,
      required String endPoint,
      String token: "",
      String query: ""}) {
    return appConfig.apiUrl +
        endPoint +
        "?v=" +
        packageInfo.version +
        "&locale=" +
        Platform.localeName +
        (token.isNotEmpty ? "&${appConfig.tokenParam}=$token" : "") +
        (query.isNotEmpty ? ("&" + query) : "");
  }
  String buildQuery(Map<String, dynamic> params) {
    String rs = "";
    params.forEach((key, value) {
      rs += "$key=${value.toString()}&";
    });
    return rs;
  }

  Future<dynamic> get(http.Client httpClient, String url) async {
    var responseJson;
    try {
      print(url);
      final response = await httpClient.get(Uri.parse(url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(
      http.Client httpClient, String url, Map<String, dynamic> body) async {
    var responseJson;
    print(url);
    print(body);
    try {
      final response = await httpClient.post(Uri.parse(url), body: body);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<String> postImage(String url, File file) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('image', file.path));
      return returnResponseStream(await request.send());
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> postImageHasContent(
      String url, File file, Map<String, String> body) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll(body);
      request.files.add(await http.MultipartFile.fromPath('image', file.path));

      final str = await returnResponseStream(await request.send());
      return json.decode(str);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body.toString());
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 500:
      case 502:
      default:
        throw FetchDataException('Server Error : ${response.statusCode}');
    }
  }

  dynamic returnResponseStream(http.StreamedResponse response) {
    switch (response.statusCode) {
      case 200:
        return response.stream.bytesToString();
      case 400:
        throw BadRequestException(response.stream.bytesToString());
      case 401:
      case 403:
        throw UnauthorizedException(response.stream.bytesToString());
      case 500:
      case 502:
      default:
        throw FetchDataException(
            'Server Error 5xx : ${response.stream.bytesToString()}');
    }
  }
}
