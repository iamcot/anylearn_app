import 'package:equatable/equatable.dart';

class DocDTO extends Equatable {
  final String content;
  final DateTime lastUpdate;

  DocDTO({this.content, this.lastUpdate});

  @override
  List<Object> get props => [content, lastUpdate];

  static DocDTO fromJson(json) {
    return json == null
        ? null
        : DocDTO(
            content: json['content'],
            lastUpdate: DateTime.parse(json['updated_at']),
          );
  }
}
