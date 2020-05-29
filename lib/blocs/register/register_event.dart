import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../dto/user_dto.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterFormLoadEvent extends RegisterEvent {
  @override
  List<Object> get props => [];
}

class RegisterButtonPressedEvent extends RegisterEvent {
  final UserDTO userInput;

  RegisterButtonPressedEvent({@required this.userInput});

  @override
  List<Object> get props => [userInput];

  @override
  String toString() => 'RegisterButtonPressedEvent { user: $userInput}';
}
