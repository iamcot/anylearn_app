import 'package:equatable/equatable.dart';

import '../../dto/class_registered_user.dart';
import '../../dto/item_dto.dart';
import '../../dto/item_user_action.dart';
import '../../dto/user_courses_dto.dart';

abstract class CourseState extends Equatable {
  const CourseState();
  @override
  List<Object> get props => [];
}

class CourseInitState extends CourseState {}

class CourseLoadingState extends CourseState {}

class CourseLoadSuccess extends CourseState {
  final ItemDTO item;
  const CourseLoadSuccess({required this.item});
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

  CourseListSuccessState({required this.data});

  @override
  List<Object> get props => [data];
  @override
  String toString() => 'UserCoursesDTO {data: $data}';
}

class UploadImageInprogressState extends CourseState {}

class UploadImageSuccessState extends CourseState {
  final String url;
  const UploadImageSuccessState({required this.url});
  @override
  List<Object> get props => [url];
  @override
  String toString() => '{url: $url}';
}

class CourseUserStatusInprogressState extends CourseState {}

class CourseUserStatusSuccessState extends CourseState {}

class CourseFailState extends CourseState {
  final String error;
  const CourseFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}

class RegisteredUsersSuccessState extends CourseState {
  final List<ClassRegisteredUserDTO> users;

  RegisteredUsersSuccessState({required this.users});

  @override
  List<Object> get props => [users];

  @override
  String toString() => 'RegisteredUsersSuccessState {}';
}

class ReviewSubmitingState extends CourseState {}

class ReviewSubmitFailState extends CourseState {}

class ReviewSubmitSuccessState extends CourseState {
  final bool result;

  ReviewSubmitSuccessState({required this.result});

  @override
  List<Object> get props => [result];

  @override
  String toString() => 'ReviewSubmitSuccessState {result: $result}';
}

class ReviewLoadSuccessState extends CourseState {
  final List<ItemUserAction> data;

  ReviewLoadSuccessState({required this.data});

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'ReviewLoadSuccessState';
}

class ReviewLoadingState extends CourseState {}
