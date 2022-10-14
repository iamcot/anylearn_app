import 'package:equatable/equatable.dart';

import 'action_dto.dart';
import 'user_dto.dart';

class PostDTO {
  final int id;
  final int status; // 1 active; 0 inactive
  final String title;
  final String description;
  final List<String> images;
  final int? likeCounts;
  final bool? liked;
  final UserDTO? user;
  final DateTime? createdAt;
  final List<ActionDTO>? comments;
  final List<ActionDTO>? likes;
  PostDTO({
    this.id = 0,
    this.status = 1,
    required this.title,
    required this.description,
    required this.images,
    this.likeCounts,
    this.liked,
    this.user,
    this.createdAt,
    this.comments,
    this.likes,
  });
  factory PostDTO.fromJson(Map<String, dynamic> json) => PostDTO(
        id: json['id'] as int,
        status: json['status'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        images: List<String>.from(json['images']
            ?.map((e) => e == null ? null : PostDTO.fromJson(e))).toList(),
        likeCounts: json['like_counts'] as int?,
        liked: json['liked'] as bool?,
        user: json['user'] == null
            ? null
            : UserDTO.fromJson(json['user'] as Map<String, dynamic>),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        comments: List<ActionDTO>.from(json['comments']
            ?.map((e) => e == null ? null : ActionDTO.fromJson(e))).toList(),
      

        likes: List<ActionDTO>.from(json['like']
            ?.map((e) => e == null ? null : ActionDTO.fromJson(e))).toList(),
      );
}

class PostPagingDTO extends Equatable {
  final currentPage;
  final data;
  final from;
  final lastPage;
  final perPage;
  final to;
  final total;

  PostPagingDTO({this.currentPage, this.data, this.from, this.lastPage, this.perPage, this.to, this.total});

  @override
  List<Object> get props => [currentPage, data, from, lastPage, perPage, to, total];

  @override
  String toString() {
    return 'PostPagingDTO {currentPage: $currentPage, total: $total, perPage: $perPage}';
  }

  static PostPagingDTO fromJson(dynamic json) {
    return json == ""
        ? PostPagingDTO()
        : PostPagingDTO(
            currentPage: json['current_page'],
            data: List<PostPagingDTO>.from(json['data']?.map((v) => v == null ? null : PostPagingDTO.fromJson(v))).toList(),
            // from: json['from'],
            // to: json['to'],
            perPage: json['per_page'],
            // lastPage: json['last_page'],
            total: json['total'],
          );
  }
}

