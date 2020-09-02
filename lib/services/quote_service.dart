import 'package:http/http.dart' as http;

import '../dto/quote_dto.dart';
import 'base_service.dart';

class QuoteService extends BaseService {
  final http.Client httpClient;

  QuoteService({this.httpClient});

  Future<QuoteDTO> getQuote(String url) async {
    final _url = url ?? 'https://quote-garden.herokuapp.com/quotes/random';
    final json = await get(httpClient, _url);
    return QuoteDTO.fromJson(json);
  }
}
