import 'package:anylearn/dto/ask_paging_dto.dart';
import 'package:anylearn/dto/ask_thread_dto.dart';
import 'package:bloc/bloc.dart';

import '../../models/page_repo.dart';
import 'article_blocs.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final PageRepository pageRepository;
  ArticleBloc({required this.pageRepository}) : super(ArticleInitState());

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
    try {
      if (event is AskIndexEvent) {
        yield AskIndexLoadingState();
        final AskPagingDTO result = await pageRepository.getAskList();
        yield AskIndexSuccessState(data: result);
      }

      if (event is AskThreadEvent) {
        yield AskThreadLoadingState();
        final AskThreadDTO result = await pageRepository.getAskThread(event.askId, event.token);
        yield AskThreadSuccessState(data: result);
      }

      if (event is AskSelectEvent) {
        yield AskSelectLoadingState();
        final result = await pageRepository.askSelectAnswer(event.askId, event.token);
        yield AskSelectSuccessState();
      }

      if (event is AskVoteEvent) {
        yield AskVoteLoadingState();
        final result = await pageRepository.askVote(event.askId, event.type, event.token);
        yield AskVoteSuccessState();
      }
    } catch (error, trace) {
      yield AskFailState(error: error.toString());
      print(trace);
    }
    if (event is AskCreateEvent) {
      try {
        yield AskCreateLoadingState();
        final result = await pageRepository.createAsk(event.askId, event.title, event.content, event.user, event.type);
        yield AskCreateSuccessState();
      } catch (error) {
        yield AskCreateFailState(error: error.toString());
      }
    }
  }
}
