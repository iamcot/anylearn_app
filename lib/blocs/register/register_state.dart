import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitState extends RegisterState {
  final String toc;

  RegisterInitState({this.toc});

  @override
  List<Object> get props => [toc];

  @override
  String toString() => '{toc: $toc}';
}

class RegisterInprogressState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterFailState extends RegisterState {
  final String error;

  const RegisterFailState({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => '{error: $error}';
}
