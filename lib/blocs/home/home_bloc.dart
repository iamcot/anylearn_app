import 'package:bloc/bloc.dart';

import '../../models/page_repo.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PageRepository pageRepository;
  HomeBloc({this.pageRepository});

  @override
  HomeState get initialState => HomeInitState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    try {
      if (event is LoadHomeEvent) {
        yield HomeLoadingState();
        final data = await pageRepository.dataHome(event.role);
        if (data != null) {
          yield HomeSuccessState(data: data);
        } else {
          yield HomeFailState(error: "Không có config cho trang");
        }
      }
    } catch (error) {
      yield HomeFailState(error: "Có lỗi xảy ra, vui lòng thử lại. $error");
    }
  }
}
