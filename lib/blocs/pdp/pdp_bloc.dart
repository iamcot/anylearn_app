import 'package:bloc/bloc.dart';

import '../../models/page_repo.dart';
import 'pdp_event.dart';
import 'pdp_state.dart';

class PdpBloc extends Bloc<PdpEvent, PdpState> {
  final PageRepository pageRepository;
  PdpBloc({this.pageRepository});

  @override
  PdpState get initialState => PdpInitState();

  @override
  Stream<PdpState> mapEventToState(PdpEvent event) async* {
    try {
      if (event is LoadPDPEvent) {
        yield PdpLoadingState();
        if (event.id == null) {
          yield PdpFailState(error: "Truy vấn không hợp lệ");
        }
        final data = await pageRepository.dataPDP(event.id);
        if (data != null) {
          yield PdpSuccessState(data: data);
        } else {
          yield PdpFailState(error: "Error 404 - Trang không tồn tại.");
        }
      }
      if (event is PdpFavoriteAddEvent) {
        final data = await pageRepository.dataPDP(event.itemId);
        data.isFavorite = true;//TODO mock
        yield PdpFavoriteAddState(data: data);
      }
      if (event is PdpFavoriteRemoveEvent) {
        final data = await pageRepository.dataPDP(event.itemId);
        data.isFavorite = false;//TODO mock
        yield PdpFavoriteRemoveState(data: data);
      }
    } catch (error) {
      yield PdpFailState(error: "Có lỗi xảy ra, vui lòng thử lại. $error");
    }
  }
}
