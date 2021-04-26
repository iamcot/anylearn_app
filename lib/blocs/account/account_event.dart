import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../dto/user_dto.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
}

class AccInitPageEvent extends AccountEvent {
  final UserDTO user;

  AccInitPageEvent({this.user});

  @override
  List<Object> get props => [user];
  @override
  String toString() => 'AccInitPageEvent $user';
}

class AccChangeAvatarEvent extends AccountEvent {
  final File file;
  final String token;

  AccChangeAvatarEvent({this.token, this.file});
  @override
  List<Object> get props => [token, file];
  @override
  String toString() => 'AccChangeAvatarEvent';
}

class AccChangeBannerEvent extends AccountEvent {
  final File file;
  final String token;

  AccChangeBannerEvent({this.token, this.file});
  @override
  List<Object> get props => [token, file];
  @override
  String toString() => 'AccChangeBannerEvent';
}

class AccEditSubmitEvent extends AccountEvent {
  final UserDTO user;
  final String token;

  AccEditSubmitEvent({this.user, this.token});
  @override
  List<Object> get props => [user, token];
  @override
  String toString() => 'AccEditSubmitEvent $user';
}

class AccLoadFriendsEvent extends AccountEvent {
  final int userId;
  final String token;

  AccLoadFriendsEvent({this.userId, this.token});
  @override
  List<Object> get props => [userId, token];
  @override
  String toString() => 'AccLoadFriendsEvent $userId';
}

class AccLoadMyCalendarEvent extends AccountEvent {
  final String token;

  AccLoadMyCalendarEvent({this.token});
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

  AccJoinCourseEvent({this.token, this.itemId, this.scheduleId, this.childId});
  @override
  List<Object> get props => [token, itemId, scheduleId, childId];
  @override
  String toString() => 'AccJoinCourseEvent $itemId $childId';
}

class AccProfileEvent extends AccountEvent {
  final int userId;

  AccProfileEvent({this.userId});
  @override
  List<Object> get props => [userId];
  @override
  String toString() => 'AccProfileEvent $userId';
}

class AccLoadDocsEvent extends AccountEvent {
  final String token;

  AccLoadDocsEvent({this.token});
  @override
  List<Object> get props => [token];
  @override
  String toString() => 'AccLoadDocsEvent';
}

class AccAddDocEvent extends AccountEvent {
  final String token;
  final File file;

  AccAddDocEvent({this.token, this.file});
  @override
  List<Object> get props => [token, file];
  @override
  String toString() => 'AccAddDocEvent';
}

class AccRemoveDocEvent extends AccountEvent {
  final String token;
  final int fileId;

  AccRemoveDocEvent({this.token, this.fileId});
  @override
  List<Object> get props => [token, fileId];
  @override
  String toString() => 'AccRemoveDocEvent $fileId';
}

class AccSaveChildrenEvent extends AccountEvent {
  final String token;
  final String name;
  final int id;

  AccSaveChildrenEvent({this.token, this.id, this.name});
  @override
  List<Object> get props => [token, id, name];
  @override
  String toString() => 'AccSaveChildrenEvent $id, $name';
}

class AccLoadChildrenEvent extends AccountEvent {
  final String token;

  AccLoadChildrenEvent({this.token});
  @override
  List<Object> get props => [token];
  @override
  String toString() => 'AccLoadChildrenEvent';
}
