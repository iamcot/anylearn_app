import 'package:anylearn/dto/picture_dto.dart';
import 'package:anylearn/dto/user_dto.dart';
import 'package:equatable/equatable.dart';

class PostDTO {
  final String? id;
  final int? status;
  final String? title;
  final String? description;
  final List<Picture>? images;
  final int? commentCounts;
  final int? likeCounts;
  final bool? liked;
  final UserDTO? user;
  final DateTime? createdAt;
  PostDTO({
    this.id,
    this.status,
    this.title,
    this.description,
    this.images,
    this.commentCounts,
    this.likeCounts,
    this.liked,
    this.user,
    this.createdAt,
  });
  factory PostDTO.fromJson(Map<String, dynamic> json) => PostDTO(
        id: json['id'] as String?,
        status: json['status'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        images: List<Picture>.from(json['images']
            ?.map((e) => e == null ? null : PostDTO.fromJson(e))).toList(),
        commentCounts: json['comment_counts'] as int?,
        likeCounts: json['like_counts'] as int?,
        liked: json['liked'] as bool?,
        user: json['user'] == null
            ? null
            : UserDTO.fromJson(json['user'] as Map<String, dynamic>),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
      );
}
