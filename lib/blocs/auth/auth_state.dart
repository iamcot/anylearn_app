import 'package:anylearn/dto/notification_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../dto/user_dto.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitState extends AuthState {}

class AuthSuccessState extends AuthState {
  final UserDTO user;

  AuthSuccessState({@required this.user}) : assert(user != null);

  @override
  List<Object> get props => [user];
}

class AuthSubpageSuccessState extends AuthState {
  final UserDTO user;

  AuthSubpageSuccessState({@required this.user}) : assert(user != null);

  @override
  List<Object> get props => [user];
}

class AuthFailState extends AuthState {
  final String error;

  AuthFailState({this.error});

  @override
  List<Object> get props => [error];
}

class AuthTokenFailState extends AuthState {}

class AuthInProgressState extends AuthState {}