import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();
}

class ArticleIndexEvent extends ArticleEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ArticleIndexEvent';
}

class ArticleTypeEvent extends ArticleEvent {
  final type;
  final page;

  ArticleTypeEvent({this.type, this.page});
  @override
  List<Object> get props => [type, page];

  @override
  String toString() => 'ArticleTypeEvent {type: $type, page: $page}';
}

class ArticlePageEvent extends ArticleEvent {
  final id;

  ArticlePageEvent({this.id});
  @override
  List<Object> get props => [id];

  @override
  String toString() => 'ArticlePageEvent {id: $id}';
}
