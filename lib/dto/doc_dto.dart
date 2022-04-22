import 'package:equatable/equatable.dart';

class DocDTO extends Equatable {
  final content;
  final lastUpdate;

  DocDTO({this.content, this.lastUpdate});

  @override
  List<Object> get props => [content, lastUpdate];

  static DocDTO fromJson(json) {
    return json == ""
        ? DocDTO()
        : DocDTO(
            content: json['content'],
            lastUpdate: DateTime.parse(json['updated_at']),
          );
  }
}
