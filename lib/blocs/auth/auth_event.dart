import 'package:anylearn/dto/user_dto.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckEvent extends AuthEvent {}

class AuthLoggedInEvent extends AuthEvent {
  final UserDTO user;
  const AuthLoggedInEvent({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'LoggedIn {token: ${user.token}, name: ${user.name} }';
}

class AuthLoggedOutEvent extends AuthEvent {}
