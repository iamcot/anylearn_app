import 'package:bloc/bloc.dart';

import '../../models/page_repo.dart';
import '../../models/transaction_repo.dart';
import 'pdp_event.dart';
import 'pdp_state.dart';

class PdpBloc extends Bloc<PdpEvent, PdpState> {
  final PageRepository pageRepository;
  final TransactionRepository transactionRepository;
  PdpBloc({this.pageRepository, this.transactionRepository});

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
        data.isFavorite = true; //TODO mock
        yield PdpFavoriteAddState(data: data);
      }
      if (event is PdpFavoriteRemoveEvent) {
        final data = await pageRepository.dataPDP(event.itemId);
        data.isFavorite = false; //TODO mock
        yield PdpFavoriteRemoveState(data: data);
      }
      if (event is PdpFriendLoadEvent) {
        final friends = await pageRepository.allFriends(event.token);
        yield PdpShareFriendListSuccessState(friends: friends);
      }
    } catch (error) {
      yield PdpFailState(error: error.toString());
    }

    if (event is PdpFriendShareEvent) {
      try {
        await pageRepository.shareFriends(event.token, event.itemId, event.friendIds, event.isALL);
        yield PdpShareSuccessState();
      } catch (error, trace) {
        print(trace);
        yield PdpShareFailState(error: error.toString());
      }
    }

    if (event is PdpRegisterEvent) {
      try {
        final data = await transactionRepository.register(event.token, event.itemId);
        if (data) {
          yield PdpRegisterSuccessState(result: data);
        } else {
          yield PdpRegisterFailState(error: "Có lỗi xảy ra, vui lòng thử lại");
        }
      } catch (error) {
        yield PdpRegisterFailState(error: error.toString());
      }
    }
  }
}
