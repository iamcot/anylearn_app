import 'package:anylearn/dto/const.dart';
import 'package:bloc/bloc.dart';

import '../../models/page_repo.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PageRepository pageRepository;
  HomeBloc({this.pageRepository}) : super(null);

  @override
  HomeState get initialState => HomeInitState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    try {
      if (event is LoadHomeEvent) {
        yield HomeLoadingState();
        final data = await pageRepository.dataHome(
            event.user != null ? event.user.role : MyConst.ROLE_GUEST, event.user != null ? event.user.id : null);
        if (data != null) {
          data.config.ignorePopupVersion = await pageRepository.getPopupVersion();
          yield HomeSuccessState(data: data);
        } else {
          yield HomeFailState(error: "Không có config cho trang");
        }
      }
      if (event is LoadQuoteEvent) {
        yield QuoteLoadingState();
        final quote = await pageRepository.getQuote(event.url);
        if (quote == null) {
          yield QuoteFailState();
        } else {
          yield QuoteSuccessState(quote: quote);
        }
      }
    } catch (error, trace) {
      yield HomeFailState(error: "Có lỗi xảy ra, vui lòng thử lại. $error");
      print(trace.toString());
    }

    if (event is LoadGuideEvent) {
      try {
        yield GuideLoadingState();
        final doc = await pageRepository.guide(event.path);
        if (doc != null) {
          yield GuideLoadSuccessState(doc: doc);
        }
      } catch (error) {
        yield GuideFailState(error: error.toString());
      }
    }

    if (event is UpdatePopupVersionEvent) {
      try {
        await pageRepository.savePopupVersion(event.version);
        yield UpdatePopupSuccessState();
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
