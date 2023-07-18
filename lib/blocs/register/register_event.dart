part of registerbloc;

abstract class RegisterEvent {
  const RegisterEvent();
}

class RegisterFormLoadEvent extends RegisterEvent {
  @override
  List<Object> get props => [];
}

class RegisterButtonPressedEvent extends RegisterEvent {
  final UserDTO userInput;

  RegisterButtonPressedEvent({required this.userInput});

  @override
  List<Object> get props => [userInput];

  @override
  String toString() => 'RegisterButtonPressedEvent { user: $userInput}';
}
