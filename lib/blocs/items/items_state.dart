import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../dto/items_dto.dart';

abstract class ItemsState extends Equatable {
  const ItemsState();
  @override
  List<Object> get props => [];
}

class ItemsInitState extends ItemsState {}

class ItemsLoadingState extends ItemsState {}

class ItemsSchoolSuccessState extends ItemsState {
  final ItemsDTO data;
  ItemsSchoolSuccessState({@required this.data}) : assert(data != null);
  @override
  List<Object> get props => [data];
}

class ItemsTeacherSuccessState extends ItemsState {
  final ItemsDTO data;
  ItemsTeacherSuccessState({@required this.data}) : assert(data != null);
  @override
  List<Object> get props => [data];
}

class ItemsLoadFailState extends ItemsState {
  final String error;
  const ItemsLoadFailState({@required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}
