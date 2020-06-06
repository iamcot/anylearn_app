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
  final int itemId;

  AccJoinCourseEvent({this.token, this.itemId});
  @override
  List<Object> get props => [token, itemId];
  @override
  String toString() => 'AccJoinCourseEvent $itemId';
}
