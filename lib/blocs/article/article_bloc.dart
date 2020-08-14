import 'package:bloc/bloc.dart';

import '../../models/page_repo.dart';
import 'article_blocs.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final PageRepository pageRepository;
  ArticleBloc({this.pageRepository});

  @override
  ArticleState get initialState => ArticleInitState();

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    try {
      if (event is ArticleIndexEvent) {
        yield ArticleIndexLoadingState();
        final result = await pageRepository.articleIndexPage();
        yield ArticleIndexSuccessState(result: result);
      }
      if (event is ArticleTypeEvent) {
        yield ArticleTypeLoadingState();
        final result = await pageRepository.articleTypePage(event.type, event.page);
        yield ArticleTypeSuccessState(result: result);
      }
      if (event is ArticlePageEvent) {
        yield ArticlePageLoadingState();
        final result = await pageRepository.article(event.id);
        yield ArticlePageSuccessState(result: result);
      }
    } catch (error, trace) {
      yield ArticleFailState(error: error.toString());
      print(trace);
    }
  }
}
