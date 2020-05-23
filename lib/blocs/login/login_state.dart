import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override 
  List<Object> get props => [];
}

class LoginInit extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginFail extends LoginState {
  final String error;

  const LoginFail({@required this.error});

  @override 
  List<Object> get props => [error];

  @override 
  String toString() => 'LoginFail { error: $error }';
}