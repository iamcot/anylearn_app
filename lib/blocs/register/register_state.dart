import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitState extends RegisterState {}

class RegisterLoadingTocState extends RegisterState {}

class RegisterTocSuccessState extends RegisterState {
  final String toc;

  const RegisterTocSuccessState({required this.toc});

  @override
  List<Object> get props => [toc];

  @override
  String toString() => '{RegisterSuccessState}';
}

class RegisterInprogressState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterFailState extends RegisterState {
  final String error;

  const RegisterFailState({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => '{error: $error}';
}
