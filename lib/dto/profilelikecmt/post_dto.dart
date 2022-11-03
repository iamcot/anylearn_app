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
  int likeCounts;
  int commentCounts;
  int shareCounts;
  final UserDTO? user;
  final DateTime? createdAt;
  final List<ActionDTO>? comments;
  final List<ActionDTO>? likes;
  final List<ActionDTO>? share;
  bool isLiked;


  PostDTO({
    this.commentCounts = 0,
    this.shareCounts = 0,
    this.id = 0,
    this.status = 1,
    this.title,
    this.description,
    this.images,
    this.likeCounts = 0,
    this.user,
    this.createdAt,
    this.comments,
    this.likes,
    this.share,
    this.isLiked = false,
    // this.isComment = false,
    // this.isShare = false,
  });
  factory PostDTO.fromJson(Map<String, dynamic> json) => PostDTO(
        id: json['id'] ?? 0,
        status: json['status'] ?? 0,
        title: json['title'] ?? "",
        description: json['description'] ?? "",
        images: json['image'] ?? "",
        likeCounts: json['like_counts'] ?? 0,
        commentCounts: json['comment_counts'] ?? 0,
        shareCounts: json['share_counts'] ?? 0,
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
  late final currentPage;
  late final List<PostDTO> data;
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
            currentPage: json['current_page'] ?? 1,
            data: List<PostDTO>.from(json['data']
                ?.map((v) => v == null ? null : PostDTO.fromJson(v))).toList(),
            // from: json['from'],
            // to: json['to'],
            perPage: json['per_page'] ?? 10,
            // lastPage: json['last_page'],
            total: json['total'] ?? 0,
          );
  }
}
