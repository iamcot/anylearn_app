import 'package:bloc/bloc.dart';

import '../../models/page_repo.dart';
import 'search_blocs.dart';
import 'package:stream_transform/stream_transform.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final PageRepository pageRepository;
  SearchBloc({required this.pageRepository}) : super(SearchInitState());

  @override
  SearchState get initialState => SearchInitState();

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
      Stream<SearchEvent> events, transitionFn) {
    return events
        .debounce(const Duration(milliseconds: 1000))
        .switchMap((transitionFn));
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    try {
      if (event is SearchUserEvent) {
        yield SearchLoadingState();
        final result =
            await pageRepository.searchUser(event.screen, event.query);
        yield SearchUserSuccessState(users: result);
      } else if (event is SearchItemEvent) {
        yield SearchLoadingState();
        final result =
            await pageRepository.searchItem(event.screen, event.query);
        yield SearchItemSuccessState(items: result);
      }
      if (event is SearchTagsEvent) {
        yield SearchTagsLoadingState();
        final tags = await pageRepository.searchTags();
        yield SearchTagsSuccessState(tags: tags);
      }
      if (event is suggestFromKeywordEvent) {
        yield suggestFromKeywordLoadingState();
        final key =
            await pageRepository.suggestFromKeyword(event.screen, event.query);
        yield suggestFromKeywordSuccessState(key: key);
      }
    } catch (error, trace) {
      yield SearchFailState(error: error.toString());
      print(trace);
    }
  }
}
