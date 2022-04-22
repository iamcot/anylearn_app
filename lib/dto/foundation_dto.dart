import 'article_dto.dart';
import 'transaction_dto.dart';

class FoundationDTO {
  final value;
  final enableIosTrans;
  final history;
  final news;

  FoundationDTO({this.value, this.history, this.news, this.enableIosTrans});

  static FoundationDTO fromJson(dynamic json) {
    return json == ""
        ? FoundationDTO()
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
