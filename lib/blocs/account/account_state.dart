import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AccountState extends Equatable {
  const AccountState();
  @override
  List<Object> get props => [];
}

class AccountInitState extends AccountState {}

class AccountFailState extends AccountState {
  final String error;
  const AccountFailState({@required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}
