import 'package:anylearn/dto/user_dto.dart';

class ActionDTO {
  final UserDTO? user;
  final String? type; // like / comment / dislike / share
  final String? content; // empty if type != comment
  final String? file; //emtpy if type != comment
  final int? postId; //0 if like on comment
  final int? actionId; //0 if like/comment on post
  final int? likeCount;
  final DateTime? createdAt;
  final DateTime? hours;

  ActionDTO({
    this.user,
    this.type,
    this.content,
    this.postId,
    this.file,
    this.actionId,
    this.likeCount,
    this.createdAt,
    this.hours,
  });
  factory ActionDTO.fromJson(Map<String, dynamic> json) => ActionDTO(
        user: json['user'] == null
            ? null
            : UserDTO.fromJson(json['user'] as Map<String, dynamic>),
        type: json['type'] as String,
        content: json['content'] as String,
        postId: json['postId'] as int,
        actionId: json['actionId'] as int,
        likeCount: json['likeCount'] as int,
        createdAt: json['created'] == null
            ? null
            : DateTime.parse(json['created'] as String),
        hours: json['hours'] == null
            ? null
            : DateTime.parse(json['hours'] as String),
        file: json['file'] as String,
      );
}
