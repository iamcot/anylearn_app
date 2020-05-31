import 'dart:convert';
import 'dart:io';

import '../app_config.dart';
import 'package:http/http.dart' as http;

import '../customs/rest_exception.dart';

class BaseService {
  String buildUrl({AppConfig appConfig, String endPoint, String token: "", String query: ""}) {
    return appConfig.apiUrl +
        endPoint +
        (token.isNotEmpty ? "?${appConfig.tokenParam}=$token" : "") +
        (query.isNotEmpty ? ((token.isNotEmpty ? "&" : "?") + query) : "");
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
      final response = await httpClient.get(Uri.parse(url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(http.Client httpClient, String url, Map<String, dynamic> body) async {
    var responseJson;
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
    } catch (error) {
      print(error.toString());
      return "";
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
        throw FetchDataException('Server Error 5xx : ${response.stream.bytesToString()}');
    }
  }
}
