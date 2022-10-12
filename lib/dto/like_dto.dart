import 'package:anylearn/dto/user_dto.dart';

class Like {
  final String? id;
  final DateTime? createdAt;
  final UserDTO? user;
  final bool? liked;
  final int? likeCounts;
  Like({
    this.id,
    this.createdAt,
    this.user,
    this.liked,
    this.likeCounts,
  });
    String get ownerId => user?.id ?? '';
 String get displayName => user?.name ?? '';

  String? get urlUserAvatar => user?.image;
Like _$CommentFromJson(Map<String, dynamic> json) => Like(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      user: json['user'] == null
          ? null
          : UserDTO.fromJson(json['user'] as Map<String, dynamic>),
      liked: json['liked'] as bool?,
      likeCounts: json['like_count'] as int?,
    );

  
}
