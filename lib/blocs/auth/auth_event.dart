import 'package:anylearn/dto/user_dto.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckEvent extends AuthEvent {
  bool isFull = false;
  AuthCheckEvent({this.isFull});

  @override
  List<Object> get props => [isFull];

  @override
  String toString() => 'AuthCheckEvent { isFull: $isFull }';
}

class AuthSubpageCheckEvent extends AuthEvent {}

class AuthLoggedInEvent extends AuthEvent {
  final UserDTO user;
  const AuthLoggedInEvent({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'LoggedIn {token: ${user.token}, name: ${user.name} }';
}

class AuthLoggedOutEvent extends AuthEvent {
  final String token;
  const AuthLoggedOutEvent({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'AuthLoggedOutEvent';
}
