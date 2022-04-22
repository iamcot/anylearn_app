import 'package:equatable/equatable.dart';

import 'user_dto.dart';

class FriendsDTO extends Equatable {
  final user;
  final friends;

  FriendsDTO({this.user, this.friends});
  @override
  List<Object> get props => [user, friends];

  @override
  String toString() => 'FriendsDTO {user: ${user.name}, friends: ${friends.length}';

  static FriendsDTO fromJson(dynamic json) {
    return json == ""
        ? FriendsDTO()
        : FriendsDTO(
            user: UserDTO.fromJson(json['user']),
            friends: List<UserDTO>.from(json['friends']?.map((v) => v == null ? null : UserDTO.fromJson(v))).toList(),
          );
  }
}
