library articlebloc;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/dto/ask_paging_dto.dart';
import 'package:anylearn/dto/ask_thread_dto.dart';

import '../../dto/article_dto.dart';
import '../../models/page_repo.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final PageRepository pageRepository;
  ArticleBloc({required this.pageRepository}) : super(ArticleInitState()) {
    on<ArticleIndexEvent>(_onArticleIndexEvent);
    on<ArticleTypeEvent>(_onArticleTypeEvent);
    on<ArticlePageEvent>(_onArticlePageEvent);
    on<AskIndexEvent>(_onAskIndexEvent);
    on<AskThreadEvent>(_onAskThreadEvent);
    on<AskSelectEvent>(_onAskSelectEvent);
    on<AskVoteEvent>(_onAskVoteEvent);
    on<AskCreateEvent>(_onAskCreateEvent);
  }

  void _onArticleIndexEvent(ArticleIndexEvent event, Emitter<ArticleState> emit) async {
    try {
      emit(ArticleIndexLoadingState());
      final result = await pageRepository.articleIndexPage();
      emit(ArticleIndexSuccessState(result: result));
    } catch (error) {
      emit(ArticleFailState(error: error.toString()));
    }
  }

  void _onArticleTypeEvent(ArticleTypeEvent event, Emitter<ArticleState> emit) async {
    try {
      emit(ArticleTypeLoadingState());
      final result = await pageRepository.articleTypePage(event.type, event.page);
      emit(ArticleTypeSuccessState(result: result));
    } catch (error) {
      emit(ArticleFailState(error: error.toString()));
    }
  }

  void _onArticlePageEvent(ArticlePageEvent event, Emitter<ArticleState> emit) async {
    try {
      emit(ArticlePageLoadingState());
      final result = await pageRepository.article(event.id);
      emit(ArticlePageSuccessState(result: result));
    } catch (error) {
      emit(ArticleFailState(error: error.toString()));
    }
  }

  void _onAskIndexEvent(AskIndexEvent event, Emitter<ArticleState> emit) async {
    try {
      emit(AskIndexLoadingState());
      final AskPagingDTO result = await pageRepository.getAskList();
      emit(AskIndexSuccessState(data: result));
    } catch (error) {
      emit(AskFailState(error: error.toString()));
    }
  }

  void _onAskThreadEvent(AskThreadEvent event, Emitter<ArticleState> emit) async {
    try {
      emit(AskThreadLoadingState());
      final AskThreadDTO result = await pageRepository.getAskThread(event.askId, event.token);
      emit(AskThreadSuccessState(data: result));
    } catch (error) {
      emit(AskFailState(error: error.toString()));
    }
  }

  void _onAskSelectEvent(AskSelectEvent event, Emitter<ArticleState> emit) async {
    try {
      emit(AskSelectLoadingState());
      await pageRepository.askSelectAnswer(event.askId, event.token);
      emit(AskSelectSuccessState());
    } catch (error) {
      emit(AskFailState(error: error.toString()));
    }
  }

  void _onAskVoteEvent(AskVoteEvent event, Emitter<ArticleState> emit) async {
    try {
      emit(AskVoteLoadingState());
      await pageRepository.askVote(event.askId, event.type, event.token);
      emit(AskVoteSuccessState());
    } catch (error) {
      emit(AskFailState(error: error.toString()));
    }
  }

  void _onAskCreateEvent(AskCreateEvent event, Emitter<ArticleState> emit) async {
    try {
      emit(AskCreateLoadingState());
      await pageRepository.createAsk(event.askId, event.title, event.content, event.user, event.type);
      emit(AskCreateSuccessState());
    } catch (error) {
      emit(AskCreateFailState(error: error.toString()));
    }
  }

  /*@override
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
  }*/
}
