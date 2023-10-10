library searchbloc;

import 'package:anylearn/dto/v3/search_suggest_dto.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../dto/item_dto.dart';
import '../../dto/user_dto.dart';
import '../../models/page_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final PageRepository pageRepository;
  SearchBloc({required pageRepository})
      : pageRepository = pageRepository,
        super(SearchInitState()) {
    on<SearchUserEvent>(_onSearchUserEvent);
    on<SearchItemEvent>(_onSearchItemEvent);
    on<SearchTagsEvent>(_onSearchTagsEvent);
    on<SuggestFromKeywordEvent>(_onSuggestFromKeywordEvent);
  }

  void _onSearchUserEvent(SearchUserEvent event, Emitter<SearchState> emit) async {
    // emit(SearchLoadingState());
    try {
      final result = await pageRepository.searchUser(event.screen, event.query);
      return emit(SearchUserSuccessState(users: result));
    } catch (e) {
      return emit(SearchFailState(error: e.toString()));
    }
  }

  void _onSearchItemEvent(SearchItemEvent event, Emitter<SearchState> emit) async {
    // emit(SearchLoadingState());
    try {
      final result = await pageRepository.searchItem(event.screen, event.query);
      return emit(SearchItemSuccessState(items: result));
    } catch (e) {
      return emit(SearchFailState(error: e.toString()));
    }
  }

  void _onSearchTagsEvent(SearchTagsEvent event, Emitter<SearchState> emit) async {
    try {
      final result = await pageRepository.searchSuggestion(event.token);
      return emit(SearchTagsSuccessState(suggestDTO: result));
    } catch (e, trace) {
      print(trace);
      return emit(SearchFailState(error: e.toString()));
    }
  }

  void _onSuggestFromKeywordEvent(SuggestFromKeywordEvent event, Emitter<SearchState> emit) async {
    // emit(SearchLoadingState());
    try {
      final result = await pageRepository.suggestFromKeyword(event.screen, event.query);
      return emit(SuggestFromKeywordSuccessState(key: result));
    } catch (e) {
      return emit(SearchFailState(error: e.toString()));
    }
  }
}
