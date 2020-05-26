import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../dto/home_dto.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final HomeDTO data;
  HomeSuccessState({@required this.data}) : assert(data != null);
  @override
  List<Object> get props => [data];
}

class HomeFailState extends HomeState {
  final String error;
  const HomeFailState({@required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}
