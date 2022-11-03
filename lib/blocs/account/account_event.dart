import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../dto/user_dto.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
}

class AccInitPageEvent extends AccountEvent {
  final UserDTO user;

  AccInitPageEvent({required this.user});

  @override
  List<Object> get props => [user];
  @override
  String toString() => 'AccInitPageEvent $user';
}

class AccChangeAvatarEvent extends AccountEvent {
  final File file;
  final String token;

  AccChangeAvatarEvent({required this.token, required this.file});
  @override
  List<Object> get props => [token, file];
  @override
  String toString() => 'AccChangeAvatarEvent';
}

class AccChangeBannerEvent extends AccountEvent {
  final File file;
  final String token;

  AccChangeBannerEvent({required this.token, required this.file});
  @override
  List<Object> get props => [token, file];
  @override
  String toString() => 'AccChangeBannerEvent';
}

class AccEditSubmitEvent extends AccountEvent {
  final UserDTO user;
  final String token;

  AccEditSubmitEvent({required this.user, required this.token});
  @override
  List<Object> get props => [user, token];
  @override
  String toString() => 'AccEditSubmitEvent $user';
}

class AccLoadFriendsEvent extends AccountEvent {
  final int userId;
  final String token;

  AccLoadFriendsEvent({required this.userId, required this.token});
  @override
  List<Object> get props => [userId, token];
  @override
  String toString() => 'AccLoadFriendsEvent $userId';
}

class AccLoadMyCalendarEvent extends AccountEvent {
  final String token;

  AccLoadMyCalendarEvent({required this.token});
  @override
  List<Object> get props => [token];
  @override
  String toString() => 'AccLoadMyCalendarEvent';
}

class AccJoinCourseEvent extends AccountEvent {
  final String token;
  final int scheduleId;
  final int itemId;
  final int childId;

  AccJoinCourseEvent(
      {required this.token,
      required this.itemId,
      required this.scheduleId,
      required this.childId});
  @override
  List<Object> get props => [token, itemId, scheduleId, childId];
  @override
  String toString() => 'AccJoinCourseEvent $itemId $childId';
}

class AccProfileEvent extends AccountEvent {
  int userId;
  int page;
  AccProfileEvent({required this.userId, required this.page});
  @override
  List<Object> get props => [userId, page];
  @override
  String toString() => 'AccProfileEvent';
}

class AccLoadDocsEvent extends AccountEvent {
  final String token;

  AccLoadDocsEvent({required this.token});
  @override
  List<Object> get props => [token];
  @override
  String toString() => 'AccLoadDocsEvent';
}

class AccAddDocEvent extends AccountEvent {
  final String token;
  final File file;

  AccAddDocEvent({required this.token, required this.file});
  @override
  List<Object> get props => [token, file];
  @override
  String toString() => 'AccAddDocEvent';
}

class AccRemoveDocEvent extends AccountEvent {
  final String token;
  final int fileId;

  AccRemoveDocEvent({required this.token, required this.fileId});
  @override
  List<Object> get props => [token, fileId];
  @override
  String toString() => 'AccRemoveDocEvent $fileId';
}

class AccSaveChildrenEvent extends AccountEvent {
  final String token;
  final String name;
  final int id;
  final String dob;

  AccSaveChildrenEvent(
      {required this.token,
      required this.id,
      required this.name,
      required this.dob});
  @override
  List<Object> get props => [token, id, name, dob];
  @override
  String toString() => 'AccSaveChildrenEvent $id, $name, $dob';
}

class AccLoadChildrenEvent extends AccountEvent {
  final String token;

  AccLoadChildrenEvent({required this.token});
  @override
  List<Object> get props => [token];
  @override
  String toString() => 'AccLoadChildrenEvent';
}

class AccChangePassEvent extends AccountEvent {
  final String newPass;
  final String oldPass;
  final String token;

  AccChangePassEvent(
      {required this.newPass, required this.oldPass, required this.token});
  @override
  List<Object> get props => [token, newPass, oldPass];
  @override
  String toString() => 'AccChangePassEvent';
}

class AccLikeEvent extends AccountEvent {
  final UserDTO user;
  final String type;
  AccLikeEvent({required this.user, required this.type});
  List<Object> get props => [user, type];
  String toString() => 'UserLikeEvent{user: $user, type:$type}';
}

class AccCommentEvent extends AccountEvent {
  final UserDTO user;
  final String type;
  AccCommentEvent({required this.user, required this.type});
  List<Object> get props => [user, type];
  String toString() => 'UserLikeEvent{user: $user, type:$type}';
}

class AccDisLikeEvent extends AccountEvent {
  final UserDTO user;
  final String type;
  AccDisLikeEvent({required this.user, required this.type});
  List<Object> get props => [user, type];
  String toString() => 'UserLikeEvent{user: $user, type:$type}';
}

class AccShareEvent extends AccountEvent {
  final UserDTO user;
  final String type;
  AccShareEvent({required this.user, required this.type});
  List<Object> get props => [user, type];
  String toString() => 'UserLikeEvent{user: $user, type:$type}';
}

class AccDeleteCommentEvent extends AccountEvent {
  final UserDTO user;

  const AccDeleteCommentEvent({required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'AuthDeleteEvent';
}

class AccLikeCountEvent extends AccountEvent {
  final int likeCount;
  const AccLikeCountEvent({required this.likeCount});
  List<Object> get props => [likeCount];
  String toString() => 'UserLikeCountEvent';
}

class AccLoadLikesEvent extends AccountEvent {
  final int page;
  final int pageSize;

  AccLoadLikesEvent({this.page = 1, this.pageSize = 9999});

  @override
  List<Object> get props => [page, pageSize];

  @override
  String toString() =>
      'UsersLoadTeacherEvent  { page: $page, pageSize: $pageSize}';
}

class AccLoadCommentsEvent extends AccountEvent {
  final int page;
  final int pageSize;

  AccLoadCommentsEvent({this.page = 1, this.pageSize = 9999});

  @override
  List<Object> get props => [page, pageSize];

  @override
  String toString() =>
      'UsersLoadTeacherEvent  { page: $page, pageSize: $pageSize}';
}

class AccPostEvent extends AccountEvent {
  final int id;
  AccPostEvent({required this.id});
  List<Object> get props => [id];
  String toString() => 'UserPostEvent { id: $id}';
}

class AccPageProfileLoadEvent extends AccountEvent {
  int page;
  int id;

  AccPageProfileLoadEvent({required this.page, required this.id});
  @override
  List<Object> get props => [page, id];

  @override
  String toString() => 'AccPageProfileLoadEvent  {  page: $page , id $id;}';
}
