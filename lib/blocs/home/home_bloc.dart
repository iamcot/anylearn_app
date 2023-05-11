library homebloc;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../dto/const.dart';
import '../../dto/doc_dto.dart';
import '../../dto/v3/home_dto.dart';
import '../../dto/quote_dto.dart';
import '../../dto/user_dto.dart';
import '../../models/page_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PageRepository pageRepository;
  HomeBloc({required pageRepository})
      : pageRepository = pageRepository,
        super(HomeInitState()) {
    on<LoadHomeEvent>(_loadHomeEvent);
  }

  void _loadHomeEvent(LoadHomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    final data = await pageRepository.dataHome(
      event.user.role != "" ? event.user.role : MyConst.ROLE_GUEST, event.user.id);
    // data.config.ignorePopupVersion = await pageRepository.getPopupVersion();
    return emit(HomeSuccessState(data: data));
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    try {
      // if (event is LoadHomeEvent) {
      //   yield HomeLoadingState();
      //   final data =
      //       await pageRepository.dataHome(event.user.role != "" ? event.user.role : MyConst.ROLE_GUEST, event.user.id);
      //   data.config.ignorePopupVersion = await pageRepository.getPopupVersion();
      //   yield HomeSuccessState(data: data);
      // }
      // if (event is LoadQuoteEvent) {
      //   yield QuoteLoadingState();
      //   final quote = await pageRepository.getQuote(event.url);
      //   if (quote == null) {
      //     yield QuoteFailState();
      //   } else {
      //     yield QuoteSuccessState(quote: quote);
      //   }
      // }
    } catch (error, trace) {
      yield HomeFailState(error: "Có lỗi xảy ra, vui lòng thử lại. $error trace \n $trace");
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
