import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../dto/item_dto.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();
}

class LoadCourseEvent extends CourseEvent {
  final int id;
  final String token;

  LoadCourseEvent({this.id, this.token});
  @override
  List<Object> get props => [id, token];

  @override
  String toString() => 'LoadCourseEvent {id: $id}';
}

class SaveCourseEvent extends CourseEvent {
  final ItemDTO item;
  final String token;

  SaveCourseEvent({this.item, this.token});
  @override
  List<Object> get props => [item, token];

  @override
  String toString() => 'SaveCourseEvent {item: $item}';
}

class ListCourseEvent extends CourseEvent {
  final String token;

  ListCourseEvent({this.token});
  @override
  List<Object> get props => [token];

  @override
  String toString() => 'ListCourseEvent';
}

class CourseUploadImageEvent extends CourseEvent {
  final File image;
  final String token;
  final int itemId;

  CourseUploadImageEvent({this.token, this.image, this.itemId});

  @override
  List<Object> get props => [token, image, itemId];

  @override
  String toString() => 'CourseUploadImageEvent item $itemId';
}

class CourseChangeUserStatusEvent extends CourseEvent {
  final String token;
  final int itemId;
  final int newStatus;

  CourseChangeUserStatusEvent({this.token, this.newStatus, this.itemId});

  @override
  List<Object> get props => [token, newStatus, itemId];

  @override
  String toString() => 'CourseChangeUserStatusEvent item $itemId status $newStatus';
}

class RegisteredUsersEvent extends CourseEvent {
  final String token;
  final int itemId;

  RegisteredUsersEvent({this.token, this.itemId});
  @override
  List<Object> get props => [token, itemId];
  @override
  String toString() => 'RegisteredUsersEvent $itemId';
}

class ReviewSubmitEvent extends CourseEvent {
  final String token;
  final int itemId;
  final int rating;
  final String comment;

  ReviewSubmitEvent({this.token, this.itemId, this.rating, this.comment});
  @override
  List<Object> get props => [token, itemId, rating, comment];
  @override
  String toString() => 'ReviewSubmitEvent {itemId: $itemId, rating: $rating}';
}

class ReviewLoadEvent extends CourseEvent {
  final int itemId;

  ReviewLoadEvent({this.itemId});
  @override
  List<Object> get props => [itemId];
  @override
  String toString() => 'ReviewLoadEvent {itemId: $itemId}';
}
