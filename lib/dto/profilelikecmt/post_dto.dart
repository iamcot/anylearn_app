import 'package:anylearn/themes/string_utils.dart';
import 'package:equatable/equatable.dart';

import '../user_dto.dart';
import 'action_dto.dart';

class PostDTO {
  int id;
  String? type;
  int? refId;
  int? userId;
  String? content;
  String? images;
  final day;
  int status; // 1 active; 0 inactive
  final createdAt;
  final updatedAt;
  String? title;
  String? description;
  int likeCounts;
  int commentCounts;
  int shareCounts;
  UserDTO? user;
  List<PostDTO>? comments;
  final List<PostDTO>? likes;
  final List<ActionDTO>? share;
  String commentUserFirstName;
  String commentUserName;
  String commentUserImage;
  int commentUserId;

  bool isLiked;

  PostDTO({
    this.id = 0,
    this.type = "",
    this.refId = 0,
    this.userId = 0,
    this.content = "",
    this.images = "",
    this.day,
    this.status = 1,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.description,
    this.likeCounts = 0,
    this.commentCounts = 0,
    this.shareCounts = 0,
    this.user,
    this.comments,
    this.likes,
    this.share,
    this.isLiked = false,
    this.commentUserFirstName = "",
    this.commentUserName = "",
    this.commentUserImage = "",
    this.commentUserId = 0,
    // this.isComment = false,
    // this.isShare = false,
  });
  String get displayTimePostCreated =>
      StringUtils.calcTimePost(createdAt ?? DateTime.now()) ?? '';
  factory PostDTO.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return PostDTO(
        id: json['id'] ?? 0,
        type: json["type"] ?? "",
        refId: json['refId'] ?? 0,
        userId: json['userId'] ?? 0,
        content: json['content'] ?? "",
        images: json['image'] ?? "",
        day: json['day'] == null ? null : DateTime.parse(json['day']),
        status: json['status'] ?? 0,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
        title: json['title'] ?? "",
        description: json['description'] ?? "",
        likeCounts: json['like_counts'] ?? 0,
        isLiked: json['isliked'] == null
            ? false
            : (json['isliked'] == 0 ? false : true),
        commentCounts: json['comment_counts'] ?? 0,
        shareCounts: json['share_counts'] ?? 0,
        user: json['user'] == null ? UserDTO() : UserDTO.fromJson(json['user']),
        comments: json['comments'] == null
            ? []
            : List<PostDTO>.from(json['comments']
                    ?.map((e) => e == null ? PostDTO() : PostDTO.fromJson(e)))
                .toList(),
        likes: json['like'] == null
            ? []
            : List<PostDTO>.from(json['like']
                    ?.map((e) => e == null ? null : ActionDTO.fromJson(e)))
                .toList(),
        share: [],
        commentUserFirstName: json["comment_user_first_name"] ?? "",
        commentUserName: json["comment_user_name"] ?? "",
        commentUserImage: json["comment_user_image"] ?? "",
        commentUserId: json["comment_user_id"] ?? 0,
      );
    } else {
      return PostDTO();
    }
  }
}

class PostPagingDTO extends Equatable {
  final currentPage;
  List<PostDTO> data;
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
            lastPage: json['last_page'] ?? 1,
            total: json['total'] ?? 0,
          );
  }
}
