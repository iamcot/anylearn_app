import 'post_dto.dart';
import '../user_dto.dart';

class ProfileDTO {
  UserDTO profile;
  PostPagingDTO posts;

  @override
  List<Object> get props => [profile, posts];

  ProfileDTO({required this.profile, required this.posts});
  factory ProfileDTO.fromJson(Map<String, dynamic> json) => ProfileDTO(
        profile: UserDTO.fromJson(json['profile']),
        posts: PostPagingDTO.fromJson(json['post']),
      );
}
