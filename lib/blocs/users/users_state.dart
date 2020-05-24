import 'package:anylearn/dto/users_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitState extends UsersState {}

class UsersLoadingState extends UsersState {}

class UsersLoadSuccessState extends UsersState {
  final UsersDTO users;

  UsersLoadSuccessState({@required this.users}) : assert(users != null);

  @override
  List<Object> get props => [users];
}

class UsersLoadFailState extends UsersState {
  final String error;

  const UsersLoadFailState({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => '{error: $error}';
}
