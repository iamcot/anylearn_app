import 'package:anylearn/dto/item_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CourseState extends Equatable {
  const CourseState();
  @override
  List<Object> get props => [];
}

class CourseInitState extends CourseState {}

class CourseLoadingState extends CourseState {}

class CourseLoadSuccess extends CourseState {
  final ItemDTO item;
  const CourseLoadSuccess({@required this.item});
  @override
  List<Object> get props => [item];
  @override
  String toString() => 'CourseLoadSuccess {item: $item}';
}

class CourseSavingState extends CourseState {}

class CourseSaveSuccessState extends CourseState {}

class CourseFailState extends CourseState {
  final String error;
  const CourseFailState({@required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}
