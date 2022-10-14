import 'package:anylearn/dto/user_dto.dart';
import 'package:equatable/equatable.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();
}

class UsersSchoolLoadEvent extends UsersEvent {
  final int page;
  final int pageSize;

  UsersSchoolLoadEvent({this.page = 1, this.pageSize = 9999});

  @override
  List<Object> get props => [page, pageSize];

  @override
  String toString() =>
      'UsersLoadSchoolsEvent  { page: $page, pageSize: $pageSize}';
}

class UsersTeacherLoadEvent extends UsersEvent {
  final int page;
  final int pageSize;

  UsersTeacherLoadEvent({this.page = 1, this.pageSize = 9999});

  @override
  List<Object> get props => [page, pageSize];

  @override
  String toString() =>
      'UsersLoadTeacherEvent  { page: $page, pageSize: $pageSize}';
}

class UserLikeEvent extends UsersEvent {
  final UserDTO user;
  final String type;
  UserLikeEvent({required this.user, required this.type});
  List<Object> get props => [user, type];
  String toString() => 'UserLikeEvent{user: $user, type:$type}';
}

class UserCommentEvent extends UsersEvent {
  final UserDTO user;
  final String type;
  UserCommentEvent({required this.user, required this.type});
  List<Object> get props => [user, type];
  String toString() => 'UserLikeEvent{user: $user, type:$type}';
}

class UserDisLikeEvent extends UsersEvent {
  final UserDTO user;
  final String type;
  UserDisLikeEvent({required this.user, required this.type});
  List<Object> get props => [user, type];
  String toString() => 'UserLikeEvent{user: $user, type:$type}';
}

class UserShareEvent extends UsersEvent {
  final UserDTO user;
  final String type;
  UserShareEvent({required this.user, required this.type});
  List<Object> get props => [user, type];
  String toString() => 'UserLikeEvent{user: $user, type:$type}';
}

class UserDeleteCommentEvent extends UsersEvent {
  final UserDTO user;

  const UserDeleteCommentEvent({required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'AuthDeleteEvent';
}

class UserLikeCountEvent extends UsersEvent {
  final int likeCount;
  const UserLikeCountEvent({required this.likeCount});
  List<Object> get props => [likeCount];
  String toString() => 'UserLikeCountEvent';
}

class UserLoadLikesEvent extends UsersEvent {
  final int page;
  final int pageSize;

  UserLoadLikesEvent({this.page = 1, this.pageSize = 9999});

  @override
  List<Object> get props => [page, pageSize];

  @override
  String toString() =>
      'UsersLoadTeacherEvent  { page: $page, pageSize: $pageSize}';
}

class UserLoadCommentsEvent extends UsersEvent {
  final int page;
  final int pageSize;

  UserLoadCommentsEvent({this.page = 1, this.pageSize = 9999});

  @override
  List<Object> get props => [page, pageSize];

  @override
  String toString() =>
      'UsersLoadTeacherEvent  { page: $page, pageSize: $pageSize}';
}

class UserPostEvent extends UsersEvent {
  final UserDTO user;
  final int status;
  final int id;
  UserPostEvent({required this.user, required this.id, required this.status});
  List<Object> get props => [user, status, id];
  String toString() => 'UserPostEvent { user: $user, status: $status, id: $id';
}
