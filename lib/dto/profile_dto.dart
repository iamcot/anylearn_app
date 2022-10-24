import 'package:anylearn/dto/likecomment/post_dto.dart';
import 'package:anylearn/dto/user_dto.dart';

class ProfileDTO {
  final UserDTO profile ;
  final PostPagingDTO posts;
  ProfileDTO({required this.profile, required this.posts});
  factory ProfileDTO.fromJson(Map<String, dynamic> json) => ProfileDTO(
        profile: json['profile'] = UserDTO.fromJson(json['profile'] as Map<String,dynamic>),
        posts: json['posts'] = PostPagingDTO.fromJson(json['posts'] as Map<String,dynamic>),

      );
}
