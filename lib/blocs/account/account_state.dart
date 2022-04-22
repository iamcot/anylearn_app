import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../dto/account_calendar_dto.dart';
import '../../dto/friends_dto.dart';
import '../../dto/user_doc_dto.dart';
import '../../dto/user_dto.dart';

abstract class AccountState extends Equatable {
  const AccountState();
  @override
  List<Object> get props => [];
}

class AccountInitState extends AccountState {}

class AccInitPageSuccess extends AccountState {
  final UserDTO user;

  AccInitPageSuccess({required this.user});
  @override
  List<Object> get props => [user];

  @override
  String toString() => '{user: $user}';
}

class UploadAvatarInprogressState extends AccountState {}

class UploadAvatarSuccessState extends AccountState {
  final String url;

  UploadAvatarSuccessState({required this.url});

  @override
  List<Object> get props => [url];

  @override
  String toString() => 'Avatar {url: $url}';
}

class UploadBannerInprogressState extends AccountState {}

class UploadBannerSuccessState extends AccountState {
  final String url;

  UploadBannerSuccessState({required this.url});

  @override
  List<Object> get props => [url];

  @override
  String toString() => 'Banner {url: $url}';
}

class AccEditSavingState extends AccountState {}

class AccEditSaveSuccessState extends AccountState {
  final bool result;

  AccEditSaveSuccessState({required this.result});

  @override
  List<Object> get props => [result];

  @override
  String toString() => 'AccEditSaveSuccessState {result: $result}';
}

class AccFriendsLoadingState extends AccountState {}

class AccFriendsLoadSuccessState extends AccountState {
  final FriendsDTO friends;
  AccFriendsLoadSuccessState({required this.friends});

  @override
  List<Object> get props => [friends];

  @override
  String toString() => 'AccFriendsLoadSuccessState {friends: $friends}';
}

class AccMyCalendarLoadingState extends AccountState {}

class AccMyCalendarSuccessState extends AccountState {
  final AccountCalendarDTO calendar;

  AccMyCalendarSuccessState({required this.calendar});

  @override
  List<Object> get props => [calendar];

  @override
  String toString() => 'AccMyCalendarSuccessState {}';
}

class AccJoinSuccessState extends AccountState {
  final int itemId;

  AccJoinSuccessState({required this.itemId});

  @override
  List<Object> get props => [itemId];

  @override
  String toString() => 'AccJoinSuccessState $itemId';
}

class AccProfileLoadingState extends AccountState {}

class AccProfileSuccessState extends AccountState {
  final UserDTO user;

  AccProfileSuccessState({required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'AccProfileSuccessState $user';
}

class AccountFailState extends AccountState {
  final String error;
  const AccountFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}

class AccLoadDocsSuccessState extends AccountState {
  final List<UserDocDTO> userDocs;

  AccLoadDocsSuccessState({required this.userDocs});

  @override
  List<Object> get props => [userDocs];

  @override
  String toString() => 'AccLoadDocsSuccessState';
}

class AccAddDocLoadingState extends AccountState {}

class AccAddDocSuccessState extends AccountState {
  final List<UserDocDTO> userDocs;

  AccAddDocSuccessState({required this.userDocs});

  @override
  List<Object> get props => [userDocs];

  @override
  String toString() => 'AccAddDocSuccessState';
}

class AccRemoveDocSuccessState extends AccountState {
  final List<UserDocDTO> userDocs;

  AccRemoveDocSuccessState({required this.userDocs});

  @override
  List<Object> get props => [userDocs];

  @override
  String toString() => 'AccRemoveDocSuccessState';
}

class AccSaveChildrenLoadingState extends AccountState {
  @override
  String toString() => 'AccSaveChildrenLoading';
}

class AccSaveChildrenSuccessState extends AccountState {
  @override
  String toString() => 'AccSaveChildrenSuccessState';
}

class AccChildrenLoadingState extends AccountState {
  @override
  String toString() => 'AccChildrenLoadingState';
}

class AccChildrenSuccessState extends AccountState {
  final List<UserDTO> children;

  AccChildrenSuccessState({required this.children});
  @override
  String toString() => 'AccChildrenSuccessState';
}

class AccChildrenFailState extends AccountState {
  final String error;
  const AccChildrenFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}

class AccChangePassInProgressState extends AccountState {
  final String newPass;
  final String oldPass;
  final String token;

  AccChangePassInProgressState({required this.token, required this.newPass, required this.oldPass});
  @override
  String toString() => 'AccChangePassInProgressState';
}

class AccChangePassSuccessState extends AccountState {
  @override
  String toString() => 'AccChangePassSuccessState';
}

class AccChangePassFailState extends AccountState {
  final String error;
  const AccChangePassFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}
