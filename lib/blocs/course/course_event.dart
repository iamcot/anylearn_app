part of coursebloc;

abstract class CourseEvent {
  const CourseEvent();
}

class LoadCourseEvent extends CourseEvent {
  final int id;
  final String token;

  LoadCourseEvent({required this.id,required  this.token});
  @override
  List<Object> get props => [id, token];

  @override
  String toString() => 'LoadCourseEvent {id: $id}';
}

class SaveCourseEvent extends CourseEvent {
  final ItemDTO item;
  final String token;

  SaveCourseEvent({required this.item,required  this.token});
  @override
  List<Object> get props => [item, token];

  @override
  String toString() => 'SaveCourseEvent {item: $item}';
}

class ListCourseEvent extends CourseEvent {
  final String token;

  ListCourseEvent({required this.token});
  @override
  List<Object> get props => [token];

  @override
  String toString() => 'ListCourseEvent';
}

class CourseUploadImageEvent extends CourseEvent {
  final File image;
  final String token;
  final int itemId;

  CourseUploadImageEvent({required this.token,required  this.image,required  this.itemId});

  @override
  List<Object> get props => [token, image, itemId];

  @override
  String toString() => 'CourseUploadImageEvent item $itemId';
}

class CourseChangeUserStatusEvent extends CourseEvent {
  final String token;
  final int itemId;
  final int newStatus;

  CourseChangeUserStatusEvent({required this.token,required  this.newStatus,required  this.itemId});

  @override
  List<Object> get props => [token, newStatus, itemId];

  @override
  String toString() => 'CourseChangeUserStatusEvent item $itemId status $newStatus';
}

class RegisteredUsersEvent extends CourseEvent {
  final String token;
  final int itemId;

  RegisteredUsersEvent({required this.token,required  this.itemId});
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

  ReviewSubmitEvent({required this.token,required  this.itemId,required  this.rating,required  this.comment});
  @override
  List<Object> get props => [token, itemId, rating, comment];
  @override
  String toString() => 'ReviewSubmitEvent {itemId: $itemId, rating: $rating}';
}

class ReviewLoadEvent extends CourseEvent {
  final int itemId;

  ReviewLoadEvent({required this.itemId});
  @override
  List<Object> get props => [itemId];
  @override
  String toString() => 'ReviewLoadEvent {itemId: $itemId}';
}