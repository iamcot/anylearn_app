part of loginbloc;
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitState extends LoginState {}

class LoginInProgressState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailState extends LoginState {
  final String error;

  const LoginFailState({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => '{error: $error}';
}

class LoginFacebookInProgressState extends LoginState {}

class LoginFacebookSuccessState extends LoginState {}

class LoginFacebookFailState extends LoginState {
  final String error;

  const LoginFacebookFailState({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => '{error: $error}';
}

class LoginAppleInProgressState extends LoginState {}

class LoginAppleSuccessState extends LoginState {}

class LoginAppleFailState extends LoginState {
  final String error;

  const LoginAppleFailState({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => '{error: $error}';
}
