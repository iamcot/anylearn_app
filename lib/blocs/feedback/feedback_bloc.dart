library feedbackbloc;

import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/page_repo.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final PageRepository pageRepository;
  FeedbackBloc({required this.pageRepository}) : super(FeedbackInitState()) {
    on<SaveFeedbackEvent>(_onSaveFeedbackEvent);
  }

  void _onSaveFeedbackEvent(SaveFeedbackEvent event, Emitter<FeedbackState> emit) async {
    try {
      emit(FeedbackSavingState());
      final result = await pageRepository.saveFeedback(event.token, event.content, event.file);
      if (result) {
        emit(FeedbackSuccessState(result: result));
      } else {
        emit(FeedbackFailState(error: "Có lỗi xảy ra, vui lòng thử lại"));
      }
    } catch (error, trace) {
      emit(FeedbackFailState(error: error.toString()));
      print(trace);
    }
  }

  /*@override
  FeedbackState get initialState => FeedbackInitState();

  @override
  Stream<FeedbackState> mapEventToState(FeedbackEvent event) async* {
    try {
      if (event is SaveFeedbackEvent) {
        yield FeedbackSavingState();
        final result = await pageRepository.saveFeedback(event.token, event.content, event.file);
        if (result) {
          yield FeedbackSuccessState(result: result);
        } else {
          yield FeedbackFailState(error: "Có lỗi xảy ra, vui lòng thử lại");
        }
      }
    } catch (error, trace) {
      yield FeedbackFailState(error: error.toString());
      print(trace);
    }
  }*/
}
