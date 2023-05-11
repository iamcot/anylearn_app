part of authbloc;

abstract class AuthState extends Equatable {
  AuthState({
    this.user = UserDTO.empty,
    this.status = AuthenticationStatus.unknown,
    this.error = "",
  });

  @override
  List<Object> get props => [status, user, error];

  final UserDTO user;
  final AuthenticationStatus status;
  final String error;
}

class AuthInitState extends AuthState {}

class AuthInProgressState extends AuthState {
  AuthInProgressState() : super();
}

class AuthFailState extends AuthState {
  final String error;

  AuthFailState({required this.error});

  @override
  List<Object> get props => [error];
}

class AuthSuccessState extends AuthState {
  final UserDTO user;

  AuthSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthTokenFailState extends AuthState {}

class AuthSubpageSuccessState extends AuthState {
  final UserDTO user;

  AuthSubpageSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

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

class AuthResentOtpLoadingState extends AuthState {}

class AuthResentOtpSuccessState extends AuthState {}

class AuthPhoneResetLoadingState extends AuthState {}

class AuthPassResetSuccessState extends AuthState {}

class AuthPhoneResetSuccessState extends AuthState {}

class AuthCheckPhoneOTPLoadingState extends AuthState {}

class AuthCheckPhoneOTPResetSuccessState extends AuthState {}

class AuthCheckPhoneOtpFailState extends AuthState {
  final String error;

  AuthCheckPhoneOtpFailState({required this.error});

  @override
  List<Object> get props => [error];
}

class AuthPassOtpFailState extends AuthState {
  final String error;

  AuthPassOtpFailState({required this.error});

  @override
  List<Object> get props => [error];
}

class AuthPassResetFailState extends AuthState {
  final String error;

  AuthPassResetFailState({required this.error});

  @override
  List<Object> get props => [error];
}

class AuthResentOtpFailState extends AuthState {
  final String error;

  AuthResentOtpFailState({required this.error});

  @override
  List<Object> get props => [error];
}

class AuthDeleteLoadingState extends AuthState {}

class AuthDeleteSuccessState extends AuthState {}

class AuthDeleteFailState extends AuthState {
  final String error;

  AuthDeleteFailState({required this.error});

  @override
  List<Object> get props => [error];
}
