import 'package:anylearn/dto/contract.dart';
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

  AuthSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthSubpageSuccessState extends AuthState {
  final UserDTO user;

  AuthSubpageSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthFailState extends AuthState {
  final String error;

  AuthFailState({required this.error});

  @override
  List<Object> get props => [error];
}

class AuthTokenFailState extends AuthState {}

class AuthInProgressState extends AuthState {}
class AuthContractInProgressState extends AuthState {}

// class AuthContractSavingState extends AuthState {}
class AuthContractSuccessState extends AuthState {}

class AuthContractFailState extends AuthState {
  final String error;

  AuthContractFailState({required this.error});

  @override
  List<Object> get props => [error];
}

class AuthContractLoadSuccessState extends AuthState {
  final ContractDTO contract;

  AuthContractLoadSuccessState({required this.contract});

  @override
  List<Object> get props => [contract];
}

class AuthContractLoadForSignSuccessState extends AuthState {
  final ContractDTO contract;

  AuthContractLoadForSignSuccessState({required this.contract});

  @override
  List<Object> get props => [contract];
}

class AuthContractLoadFailState extends AuthState {
  final String error;

  AuthContractLoadFailState({required this.error});

  @override
  List<Object> get props => [error];
}

class AuthContractSigningState extends AuthState {}

class AuthContractSignedSuccessState extends AuthState {
  final String image;

  AuthContractSignedSuccessState({required this.image});

  @override
  List<Object> get props => [image];
}

class AuthContractSignedFailState extends AuthState {
  final String error;

  AuthContractSignedFailState({required this.error});

  @override
  List<Object> get props => [error];
}

class AuthPassOtpLoadingState extends AuthState {}

class AuthPassOtpSuccessState extends AuthState {}

class AuthPassResetLoadingState extends AuthState {}

class AuthPassResetSuccessState extends AuthState {}

class AuthPassOtpFailState extends AuthState {
  final String error;

  AuthPassOtpFailState({required this.error});

  @override
  List<Object> get props => [error];
}
