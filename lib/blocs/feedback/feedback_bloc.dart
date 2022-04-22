import 'package:bloc/bloc.dart';

import '../../models/page_repo.dart';
import 'feedback_blocs.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final PageRepository pageRepository;
  FeedbackBloc({required this.pageRepository}) : super(FeedbackInitState());

  @override
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
  }
}
