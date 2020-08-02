import 'dart:io';

import 'package:anylearn/dto/contract.dart';
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

class AuthContractSaveEvent extends AuthEvent {
  final String token;
  final ContractDTO contract;
  const AuthContractSaveEvent({@required this.token, this.contract});

  @override
  List<Object> get props => [token, contract];

  @override
  String toString() => 'AuthContractSaveEvent {contract: $contract}';
}

class AuthContractLoadEvent extends AuthEvent {
  final String token;
  const AuthContractLoadEvent({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'AuthContractLoadEvent';
}

class AuthContractSignEvent extends AuthEvent {
  final String token;
  final File file;

  const AuthContractSignEvent({@required this.token, this.file});

  @override
  List<Object> get props => [token, file];

  @override
  String toString() => 'AuthContractSignEvent';
}
