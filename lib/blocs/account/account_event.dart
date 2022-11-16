import 'dart:io';

import 'package:anylearn/dto/profilelikecmt/action_dto.dart';
import 'package:anylearn/dto/profilelikecmt/post_dto.dart';
import 'package:equatable/equatable.dart';

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
  final String token;
  final int page;
  AccProfileEvent({required this.token, required this.page});
  @override
  List<Object> get props => [token, page];
  @override
  String toString() => 'AccProfileEvent $page';
}

class AccFriendProfileEvent extends AccountEvent {
  final int userId;
  final int page;
  AccFriendProfileEvent({required this.userId, required this.page});
  @override
  List<Object> get props => [userId, page];
  @override
  String toString() => 'AccFriendProfileEvent $userId $page';
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

class AccPostContentEvent extends AccountEvent {
  final int id;
  AccPostContentEvent({required this.id});
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

class ActionUserEvent extends AccountEvent {
  final String token;
  final int id;
  final String type;
  final String content;
  ActionUserEvent(
      {required this.type,
      required this.content,
      required this.id,
      required this.token});
  List<Object> get props => [type, content, id, token];
  String toString() => 'ActionUserEvent $id';
}
