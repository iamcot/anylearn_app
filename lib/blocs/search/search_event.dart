import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchUserEvent extends SearchEvent {
  final String screen;
  final String query;

  SearchUserEvent({required this.screen, this.query = ""});
  @override
  List<Object> get props => [screen, query];

  @override
  String toString() => 'SaveSearchEvent {screen: $screen, query: $query}';
}

class SearchItemEvent extends SearchEvent {
  final String screen;
  final String query;

  SearchItemEvent({required this.screen, this.query = ""});
  @override
  List<Object> get props => [screen, query];

  @override
  String toString() => 'SaveSearchEvent {screen: $screen, query: $query}';
}

class SearchTagsEvent extends SearchEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'SearchTagsEvent {}';
}

class suggestFromKeywordEvent extends SearchEvent {
  final String screen;
  final String query;
  suggestFromKeywordEvent({required this.screen, this.query = ""});

  @override
  List<Object> get props => [screen, query];

  @override
  String toString() =>
      'suggestFromKeywordEvent {screen: $screen, query: $query }';
}
