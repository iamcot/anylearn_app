part of registerbloc;

abstract class RegisterEvent {
  const RegisterEvent();
}

class RegisterFormLoadEvent extends RegisterEvent {
}

class RegisterButtonPressedEvent extends RegisterEvent {
  final UserDTO userInput;

  RegisterButtonPressedEvent({required this.userInput});

  @override
  String toString() => 'RegisterButtonPressedEvent { user: $userInput}';
}
