import 'package:equatable/equatable.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();
}

class UsersSchoolLoadEvent extends UsersEvent {
  final int page;
  final int pageSize;

  UsersSchoolLoadEvent({this.page = 1, this.pageSize = 9999});

  @override
  List<Object> get props => [page, pageSize];

  @override
  String toString() => 'UsersLoadSchoolsEvent  { page: $page, pageSize: $pageSize}';
}

class UsersTeacherLoadEvent extends UsersEvent {
  final int page;
  final int pageSize;

  UsersTeacherLoadEvent({this.page = 1, this.pageSize = 9999});

  @override
  List<Object> get props => [page, pageSize];

  @override
  String toString() => 'UsersLoadTeacherEvent  { page: $page, pageSize: $pageSize}';
}
