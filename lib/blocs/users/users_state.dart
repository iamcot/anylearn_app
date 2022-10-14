import 'package:anylearn/dto/action_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../dto/users_dto.dart';

abstract class UsersState extends Equatable {
  const UsersState();
  @override
  List<Object> get props => [];
}

class UsersInitState extends UsersState {}

class UsersLoadingState extends UsersState {}

class UsersSchoolSuccessState extends UsersState {
  final UsersDTO data;
  UsersSchoolSuccessState({required this.data}) : assert(data != null);
  @override
  List<Object> get props => [data];
}

class UsersTeacherSuccessState extends UsersState {
  final UsersDTO data;
  UsersTeacherSuccessState({required this.data}) : assert(data != null);
  @override
  List<Object> get props => [data];
}

class UsersLoadFailState extends UsersState {
  final String error;
  const UsersLoadFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}

class UserLikeSuccessState extends UsersState {  
}

class UserCommentSuccessState extends UsersState {}

class UserDisLikeSuccessState extends UsersState {}

class UserShareSucccessState extends UsersState {}

class UserDeleteCommentSuccessState extends UsersState {}

class UserLikeCountSuccessState extends UsersState {}

class UserLoadLikesSuccessState extends UsersState {
  final List<ActionDTO> likes;
  UserLoadLikesSuccessState({required this.likes}): assert(likes != null);
  List<Object> get props => [likes];
}

class UserLoadCommentsSuccessState extends UsersState {
  final List<ActionDTO> comments;
  UserLoadCommentsSuccessState({required this.comments});
  List<Object> get props => [comments];
}

class UsersLoadLikesFailState extends UsersState {
  final String error;
  const UsersLoadLikesFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}

class UsersLoadCommentsFailState extends UsersState {
  final String error;
  const UsersLoadCommentsFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}
