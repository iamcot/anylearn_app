import 'dart:convert';

import 'package:anylearn/dto/quote_dto.dart';
import 'package:http/http.dart' as http;

class QuoteService {
  final _baseUrl = 'https://quote-garden.herokuapp.com';
  final http.Client httpClient;

  QuoteService({this.httpClient});

  Future<QuoteDTO> getQuote() async {
    final url = '$_baseUrl/quotes/random';
    final response = await this.httpClient.get(url);
    if (response.statusCode != 200) {
      return null;
    }
    final json = jsonDecode(response.body);
    return QuoteDTO.fromJson(json);
  }
}
