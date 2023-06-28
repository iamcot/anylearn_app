part of searchbloc;
abstract class SearchEvent{
  const SearchEvent();
}

class SearchUserEvent extends SearchEvent {
  final String screen;
  final String query;

  SearchUserEvent({required this.screen, this.query = ""});
}

class SearchItemEvent extends SearchEvent {
  final String screen;
  final String query;

  SearchItemEvent({required this.screen, this.query = ""});
}

class SearchTagsEvent extends SearchEvent { 
  final String screen;
  final String query;

  SearchTagsEvent({required this.screen, this.query = ""});
}

class SuggestFromKeywordEvent extends SearchEvent {
  final String screen;
  final String query;
  SuggestFromKeywordEvent({required this.screen, this.query = ""});
}
