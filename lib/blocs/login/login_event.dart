import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressedEvent extends LoginEvent {
  final String phone;
  final String password;

  LoginButtonPressedEvent({@required this.phone, @required this.password});

  @override
  List<Object> get props => [phone, password];

  @override 
  String toString() => 'LoginButtonPressed { phone: $phone, password: $password}';
  
}