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
  String toString() => 'LoginFail { error: $error }';
}