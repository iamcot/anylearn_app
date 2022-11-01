import 'post_dto.dart';
import '../user_dto.dart';

class ProfileDTO {
  final UserDTO profile ;
  late final PostPagingDTO posts;

  @override
  List<Object> get props => [profile, posts];

  ProfileDTO({required this.profile, required this.posts});
  factory ProfileDTO.fromJson(Map<String, dynamic> json) => ProfileDTO(
        profile: json['profile'] = UserDTO.fromJson(json['profile']),
        posts: json['posts'] = PostPagingDTO.fromJson(json['posts']),

      );
}
