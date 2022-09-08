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
  AuthCheckEvent({this.isFull = false});

  @override
  List<Object> get props => [isFull];

  @override
  String toString() => 'AuthCheckEvent { isFull: $isFull }';
}

class AuthSubpageCheckEvent extends AuthEvent {}

class AuthLoggedInEvent extends AuthEvent {
  final UserDTO user;
  const AuthLoggedInEvent({required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'LoggedIn {token: ${user.token}, name: ${user.name} }';
}

class AuthLoggedOutEvent extends AuthEvent {
  final String token;
  const AuthLoggedOutEvent({required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'AuthLoggedOutEvent';
}

class AuthContractSaveEvent extends AuthEvent {
  final String token;
  final ContractDTO contract;
  const AuthContractSaveEvent({required this.token, required this.contract});

  @override
  List<Object> get props => [token, contract];

  @override
  String toString() => 'AuthContractSaveEvent {contract: $contract}';
}

class AuthContractLoadEvent extends AuthEvent {
  final String token;
  final int contractId;
  const AuthContractLoadEvent({required this.token, required this.contractId});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'AuthContractLoadEvent';
}

class AuthContractLoadForSignEvent extends AuthEvent {
  final String token;
  final int contractId;
  const AuthContractLoadForSignEvent(
      {required this.token, required this.contractId});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'AuthContractLoadEvent';
}

class AuthContractSignEvent extends AuthEvent {
  final String token;
  final int contractId;

  const AuthContractSignEvent({required this.token, required this.contractId});

  @override
  List<Object> get props => [token, contractId];

  @override
  String toString() => 'AuthContractSignEvent';
}

class AuthPassOtpEvent extends AuthEvent {
  final String phone;
  const AuthPassOtpEvent({required this.phone});

  @override
  List<Object> get props => [phone];

  @override
  String toString() => 'AuthPassOtpEvent phone: $phone';
}

class AuthPhoneResetEvent extends AuthEvent {
  final String otp;
  final String phone;
  // final String password;
  // final String confirmPassword;
  const AuthPhoneResetEvent({
    required this.phone,
    required this.otp,
  });

  @override
  List<Object> get props => [phone];

  @override
  String toString() => 'AuthPhoneResetEvent phone: $phone';
}
class AuthOTPResetEvent extends AuthEvent {
  final String otp;
  // final String phone;
  // final String password;
  // final String confirmPassword;
  const AuthOTPResetEvent({
    // required this.phone,
    required this.otp,
  });

  @override
  List<Object> get props => [otp];

  @override
  String toString() => 'AuthOTPResetEvent phone: $otp';
}

class AuthPassResetEvent extends AuthEvent {
  final String password;
  final String confirmPassword;
  const AuthPassResetEvent(
      {required this.password, required this.confirmPassword});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'AuthPassResetEvent phone: $password';
}
