import 'package:anylearn/blocs/course/course_blocs.dart';
import 'package:anylearn/dto/item_dto.dart';
import 'package:anylearn/dto/user_courses_dto.dart';
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

class CourseListLoadingState extends CourseState {}

class CourseListSuccessState extends CourseState {
  final UserCoursesDTO data;

  CourseListSuccessState({this.data});

  @override
  List<Object> get props => [data];
  @override
  String toString() => 'UserCoursesDTO {data: $data}';
}

class UploadImageInprogressState extends CourseState {}

class UploadImageSuccessState extends CourseState {
  final String url;
  const UploadImageSuccessState({@required this.url});
  @override
  List<Object> get props => [url];
  @override
  String toString() => '{url: $url}';
}

class CourseUserStatusInprogressState extends CourseState {}

class CourseUserStatusSuccessState extends CourseState {}

class CourseFailState extends CourseState {
  final String error;
  const CourseFailState({@required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}
