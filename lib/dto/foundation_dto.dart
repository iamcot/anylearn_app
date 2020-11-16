import 'article_dto.dart';
import 'transaction_dto.dart';

class FoundationDTO {
  final value;
  final bool enableIosTrans;
  final List<TransactionDTO> history;
  final List<ArticleDTO> news;

  FoundationDTO({this.value, this.history, this.news, this.enableIosTrans});

  static FoundationDTO fromJson(dynamic json) {
    return json == null
        ? null
        : FoundationDTO(
            value: json['value'],
            enableIosTrans: json['ios_transaction'] == null ? false : (json['ios_transaction'] == 1),
            history: json['history'] == null
                ? null
                : List<TransactionDTO>.from(
                    json['history']?.map(
                      (e) => e == null ? null : TransactionDTO.fromJson(e),
                    ),
                  ),
            news: json['news'] == null
                ? null
                : List<ArticleDTO>.from(
                    json['news']?.map(
                      (e) => e == null ? null : ArticleDTO.fromJson(e),
                    ),
                  ),
          );
  }
}
