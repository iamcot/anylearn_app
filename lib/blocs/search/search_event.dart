import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchUserEvent extends SearchEvent {
  final String screen;
  final String query;

  SearchUserEvent({this.screen, this.query});
  @override
  List<Object> get props => [screen, query];

  @override
  String toString() => 'SaveSearchEvent {screen: $screen, query: $query}';
}


class SearchItemEvent extends SearchEvent {
  final String screen;
  final String query;

  SearchItemEvent({this.screen, this.query});
  @override
  List<Object> get props => [screen, query];

  @override
  String toString() => 'SaveSearchEvent {screen: $screen, query: $query}';
}
