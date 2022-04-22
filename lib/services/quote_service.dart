import 'package:http/http.dart' as http;

import '../dto/quote_dto.dart';
import 'base_service.dart';

class QuoteService extends BaseService {
  final http.Client httpClient;

  QuoteService({required this.httpClient});

  Future<QuoteDTO> getQuote(String url) async {
    final _url = url;
    final json = await get(httpClient, _url);
    return QuoteDTO.fromJson(json);
  }
}
