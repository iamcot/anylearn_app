import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();
}

class ItemsSchoolLoadEvent extends ItemsEvent {
  final int id;
  final int page;
  final int pageSize;

  ItemsSchoolLoadEvent({required this.id, this.page = 1, this.pageSize = 9999});

  @override
  List<Object> get props => [id, page, pageSize];

  @override
  String toString() => 'ItemsSchoolLoadEvent  { page: $page, pageSize: $pageSize}';
}

class ItemsTeacherLoadEvent extends ItemsEvent {
  final int id;
  final int page;
  final int pageSize;

  ItemsTeacherLoadEvent({required this.id, this.page = 1, this.pageSize = 9999});

  @override
  List<Object> get props => [id, page, pageSize];

  @override
  String toString() => 'ItemsTeacherLoadEvent  { page: $page, pageSize: $pageSize}';
}

class CategoryLoadEvent extends ItemsEvent {
  final int id;
  final int page;
  final int pageSize;

  CategoryLoadEvent({required this.id, this.page = 1, this.pageSize = 9999});

  @override
  List<Object> get props => [id, page, pageSize];

  @override
  String toString() => 'CategoryLoadEvent  { page: $page, pageSize: $pageSize}';
}
