import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../customs/rest_exception.dart';

class BaseService {
  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(url);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
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
}
