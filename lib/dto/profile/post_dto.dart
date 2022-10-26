import 'package:anylearn/dto/picture_dto.dart';
import 'package:equatable/equatable.dart';

import 'action_dto.dart';
import '../user_dto.dart';

class PostDTO {
  final int id;
  final int status; // 1 active; 0 inactive
  final String? title;
  final String? description;
  final String? images;
  final int? likeCounts;
  final int? commentCounts;
  final int? shareCounts;
  final UserDTO? user;
  final DateTime? createdAt;
  final List<ActionDTO>? comments;
  final List<ActionDTO>? likes;
  final List<ActionDTO>? share;

  PostDTO({
    this.commentCounts,
    this.shareCounts,
    this.id = 0,
    this.status = 1,
    this.title,
    this.description,
    this.images,
    this.likeCounts,
    this.user,
    this.createdAt,
    this.comments,
    this.likes,
    this.share,
  });
  factory PostDTO.fromJson(Map<String, dynamic> json) => PostDTO(
        id: json['id'] ?? 0,
        status: json['status'] ?? 0,
        title: json['title'] as String,
        description: json['description'] as String,
        images: json['image'] ?? "",
        likeCounts: json['like_counts'] as int?,
        commentCounts: json['comment_counts'] as int?,
        shareCounts: json['share_counts'] as int?,
        user: json['user'] == null ? UserDTO() : UserDTO.fromJson(json['user']),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        comments: List<ActionDTO>.from(json['comments']
                ?.map((e) => e == null ? ActionDTO() : ActionDTO.fromJson(e)))
            .toList(),
        likes: List<ActionDTO>.from(json['like']
            ?.map((e) => e == null ? null : ActionDTO.fromJson(e))).toList(),
      );
}

class PostPagingDTO extends Equatable {
  final currentPage;
  final List<PostDTO> data;
  final from;
  final lastPage;
  final perPage;
  final to;
  final total;

  PostPagingDTO(
      {this.currentPage,
      required this.data,
      this.from,
      this.lastPage,
      this.perPage,
      this.to,
      this.total});

  @override
  List<Object> get props =>
      [currentPage, data, from, lastPage, perPage, to, total];

  @override
  String toString() {
    return 'PostPagingDTO {currentPage: $currentPage, total: $total, perPage: $perPage}';
  }

  static PostPagingDTO fromJson(dynamic json) {
    return json == ""
        ? PostPagingDTO(data: [])
        : PostPagingDTO(
            currentPage: json['current_page'],
            data: List<PostDTO>.from(json['data']
                ?.map((v) => v == null ? null : PostDTO.fromJson(v))).toList(),
            // from: json['from'],
            // to: json['to'],
            perPage: json['per_page'],
            // lastPage: json['last_page'],
            total: json['total'],
          );
  }
}
