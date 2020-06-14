import 'package:anylearn/blocs/account/account_blocs.dart';
import 'package:anylearn/dto/account_calendar_dto.dart';
import 'package:anylearn/dto/friends_dto.dart';
import 'package:anylearn/dto/user_doc_dto.dart';
import 'package:anylearn/dto/user_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AccountState extends Equatable {
  const AccountState();
  @override
  List<Object> get props => [];
}

class AccountInitState extends AccountState {}

class AccInitPageSuccess extends AccountState {
  final UserDTO user;

  AccInitPageSuccess({this.user});
  @override
  List<Object> get props => [user];

  @override
  String toString() => '{user: $user}';
}

class UploadAvatarInprogressState extends AccountState {}

class UploadAvatarSuccessState extends AccountState {
  final String url;

  UploadAvatarSuccessState({this.url});

  @override
  List<Object> get props => [url];

  @override
  String toString() => 'Avatar {url: $url}';
}

class UploadBannerInprogressState extends AccountState {}

class UploadBannerSuccessState extends AccountState {
  final String url;

  UploadBannerSuccessState({this.url});

  @override
  List<Object> get props => [url];

  @override
  String toString() => 'Banner {url: $url}';
}

class AccEditSavingState extends AccountState {}

class AccEditSaveSuccessState extends AccountState {
  final bool result;

  AccEditSaveSuccessState({this.result});

  @override
  List<Object> get props => [result];

  @override
  String toString() => 'AccEditSaveSuccessState {result: $result}';
}

class AccFriendsLoadingState extends AccountState {}

class AccFriendsLoadSuccessState extends AccountState {
  final FriendsDTO friends;
  AccFriendsLoadSuccessState({this.friends});

  @override
  List<Object> get props => [friends];

  @override
  String toString() => 'AccFriendsLoadSuccessState {friends: $friends}';
}

class AccMyCalendarLoadingState extends AccountState {}

class AccMyCalendarSuccessState extends AccountState {
  final AccountCalendarDTO calendar;

  AccMyCalendarSuccessState({this.calendar});

  @override
  List<Object> get props => [calendar];

  @override
  String toString() => 'AccMyCalendarSuccessState {}';
}

class AccJoinSuccessState extends AccountState {
  final int result;

  AccJoinSuccessState({this.result});

  @override
  List<Object> get props => [result];

  @override
  String toString() => 'AccJoinSuccessState $result';
}

class AccProfileLoadingState extends AccountState {}

class AccProfileSuccessState extends AccountState {
  final UserDTO user;

  AccProfileSuccessState({this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'AccProfileSuccessState $user';
}

class AccountFailState extends AccountState {
  final String error;
  const AccountFailState({@required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}

class AccLoadDocsSuccessState extends AccountState {
  final List<UserDocDTO> userDocs;

  AccLoadDocsSuccessState({this.userDocs});

  @override
  List<Object> get props => [userDocs];

  @override
  String toString() => 'AccLoadDocsSuccessState';
}
class AccAddDocLoadingState extends AccountState {}

class AccAddDocSuccessState extends AccountState {
  final List<UserDocDTO> userDocs;

  AccAddDocSuccessState({this.userDocs});

  @override
  List<Object> get props => [userDocs];

  @override
  String toString() => 'AccAddDocSuccessState';
}

class AccRemoveDocSuccessState extends AccountState {
  final List<UserDocDTO> userDocs;

  AccRemoveDocSuccessState({this.userDocs});

  @override
  List<Object> get props => [userDocs];

  @override
  String toString() => 'AccRemoveDocSuccessState';
}
