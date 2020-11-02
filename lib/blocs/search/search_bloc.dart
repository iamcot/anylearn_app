import 'package:bloc/bloc.dart';

import '../../models/page_repo.dart';
import 'search_blocs.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final PageRepository pageRepository;
  SearchBloc({this.pageRepository});

  @override
  SearchState get initialState => SearchInitState();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    try {
      if (event is SearchUserEvent) {
        yield SearchLoadingState();
        final result = await pageRepository.searchUser(event.screen, event.query);
        yield SearchUserSuccessState(users: result);
      } else if (event is SearchItemEvent) {
        yield SearchLoadingState();
        final result = await pageRepository.searchItem(event.screen, event.query);
        yield SearchItemSuccessState(items: result);
      }
      if (event is SearchTagsEvent) {
        yield SearchTagsLoadingState();
        final tags = await pageRepository.searchTags();
        yield SearchTagsSuccessState(tags: tags);
      }
    } catch (error, trace) {
      yield SearchFailState(error: error.toString());
      print(trace);
    }
  }
}
