import 'package:anylearn/dto/user_dto.dart';

class Comment {
  final String? id;
  final int? status;
  final DateTime? createdAt;
  final String? content;
  final UserDTO? user;
  final bool? liked;

  final int? likeCounts;
  Comment({
    this.id,
    this.status,
    this.createdAt,
    this.content,
    this.user,
    this.liked,
    this.likeCounts,
  });
    String get ownerId => user?.id ?? '';
 String get displayName => user?.name ?? '';

  String? get urlUserAvatar => user?.image;
Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as String?,
      status: json['status'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      content: json['content'] as String?,
      user: json['user'] == null
          ? null
          : UserDTO.fromJson(json['user'] as Map<String, dynamic>),
      liked: json['liked'] as bool?,
      likeCounts: json['like_count'] as int?,
    );

  
}
