import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressedEvent extends LoginEvent {
  final String phone;
  final String password;

  LoginButtonPressedEvent({required this.phone, required this.password});

  @override
  List<Object> get props => [phone, password];

  @override 
  String toString() => 'LoginButtonPressed { phone: $phone, password: $password}';
  
}


class LoginFacebookEvent extends LoginEvent {
  final Map<String, dynamic> data;

  LoginFacebookEvent({required this.data});

  @override
  List<Object> get props => [data];

  @override 
  String toString() => 'LoginFacebookEvent { data: $data}';
  
}


class LoginAppleEvent extends LoginEvent {
  final Map<String, dynamic> data;

  LoginAppleEvent({required this.data});

  @override
  List<Object> get props => [data];

  @override 
  String toString() => 'LoginAppleEvent { data: $data}';
  
}