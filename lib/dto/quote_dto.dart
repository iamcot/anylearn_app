import 'package:equatable/equatable.dart';

class QuoteDTO extends Equatable {
  final id;
  final text;
  final author;

  QuoteDTO({this.id, this.text, this.author});

  @override
  List<Object> get props => [id, text, author];

  static QuoteDTO fromJson(dynamic json) {
    return QuoteDTO(
      id: json['_id'],
      text: json['quoteText'],
      author: json['quoteAuthor'],
    );
  }

  @override
  String toString() => 'Quote {id: $id, text: $text, author: $author}';
}
