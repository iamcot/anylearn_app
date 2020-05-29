import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitState extends LoginState {}

class LoginInProgressState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailState extends LoginState {
  final String error;

  const LoginFailState({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => '{error: $error}';
}

class RegisterInitState extends LoginState {
  final String toc;

  RegisterInitState({this.toc});

  @override 
  List<Object> get props => [toc];

  @override
  String toString() => '{toc: $toc}';
}

class RegisterInprogressState extends LoginState {}

class RegisterSuccessState extends LoginState {}

class RegisterFailState extends LoginState {
  final String error;

  const RegisterFailState({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => '{error: $error}';
}
