part of loginbloc;

abstract class LoginEvent {
  const LoginEvent();
}

class LoginButtonPressedEvent extends LoginEvent {
  final String phone;
  final String password;

  LoginButtonPressedEvent({required this.phone, required this.password});
}


class LoginFacebookEvent extends LoginEvent {
  final Map<String, dynamic> data;

  LoginFacebookEvent({required this.data});
}


class LoginAppleEvent extends LoginEvent {
  final Map<String, dynamic> data;

  LoginAppleEvent({required this.data});

}