import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthUnInit extends AuthState {}

class AuthChecked extends AuthState {}

class AuthUnCheck extends AuthState {}

class AuthLoading extends AuthState {}

