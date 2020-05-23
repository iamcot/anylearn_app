import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInit extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFail extends AuthState {}

class AuthInProgress extends AuthState {}

