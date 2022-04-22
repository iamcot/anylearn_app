import 'package:anylearn/dto/user_dto.dart';
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

class AskIndexEvent extends ArticleEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AskIndexEvent';
}

class AskThreadEvent extends ArticleEvent {
  final askId;
  final token;

  AskThreadEvent({this.askId, this.token});

  @override
  List<Object> get props => [askId, token];

  @override
  String toString() => 'AskThreadEvent';
}

class AskCreateEvent extends ArticleEvent {
  final askId;
  final String content;
  final String title;
  final String type;
  final UserDTO user;

  AskCreateEvent({required this.content, required this.title, required this.type, required this.user, this.askId});

  @override
  List<Object> get props => [askId, content, title, type, user];

  @override
  String toString() => 'AskCreateEvent {type: $type}';
}

class AskSelectEvent extends ArticleEvent {
  final askId;
  final String token;

  AskSelectEvent({this.askId, required this.token});

  @override
  List<Object> get props => [askId, token];

  @override
  String toString() => 'AskSelectEvent {askId: $askId}';
}

class AskVoteEvent extends ArticleEvent {
  final askId;
  final String type;
  final String token;

  AskVoteEvent({this.askId, required this.type, required this.token});

  @override
  List<Object> get props => [askId, token, type];

  @override
  String toString() => 'AskVoteEvent {askId: $askId, type: $type}';
}
