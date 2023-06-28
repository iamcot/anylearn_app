library pdpbloc;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../dto/pdp_dto.dart';
import '../../dto/user_dto.dart';
import '../../models/page_repo.dart';
import '../../models/transaction_repo.dart';

part 'pdp_event.dart';
part 'pdp_state.dart';

class PdpBloc extends Bloc<PdpEvent, PdpState> {
  final PageRepository pageRepository;
  final TransactionRepository transactionRepository;
  PdpBloc({required this.pageRepository, required this.transactionRepository}) : super(PdpInitState()) {
    on<LoadPDPEvent>(_loadPDPEvent);
    on<PdpFavoriteTouchEvent>(_pdpFavoriteTouchEvent);
    on<PdpFriendLoadEvent>(_pdpFriendLoadEvent);
    on<PdpFriendShareEvent>(_pdpFriendShareEvent);
    on<PdpRegisterEvent>(_pdpRegisterEvent);
  }

  void _loadPDPEvent(LoadPDPEvent event, Emitter<PdpState> emit) async {
    try {
      final data = await pageRepository.dataPDP(event.id, event.token);
      return emit(PdpSuccessState(data: data));
    } catch (error) {
      return emit(PdpFailState(error: "Error 404 - Trang không tồn tại."));
    }
  }

  void _pdpFavoriteTouchEvent(PdpFavoriteTouchEvent event, Emitter<PdpState> emit) async {
    try {
      final rs = await pageRepository.touchFav(event.itemId, event.token);
      return emit(PdpFavoriteTouchSuccessState(isFav: rs));
    } catch (error) {
      return emit(PdpFailState(error: error.toString()));
    }
  }

  void _pdpFriendLoadEvent(PdpFriendLoadEvent event, Emitter<PdpState> emit) async {
    try {
      final friends = await pageRepository.allFriends(event.token);
      return emit(PdpShareFriendListSuccessState(friends: friends));
    } catch (error) {
      return emit(PdpFailState(error: error.toString()));
    }
  }

  void _pdpFriendShareEvent(PdpFriendShareEvent event, Emitter<PdpState> emit) async {
    try {
      await pageRepository.shareFriends(event.token, event.itemId, event.friendIds, event.isALL);
      return emit(PdpShareSuccessState());
    } catch (error) {
      return emit(PdpShareFailState(error: error.toString()));
    }
  }

  void _pdpRegisterEvent(PdpRegisterEvent event, Emitter<PdpState> emit) async {
    try {
      final data = await transactionRepository.register(event.token, event.itemId, event.voucher, event.childUser);
      return emit(PdpRegisterSuccessState(result: data));
    } catch (error) {
      return emit(PdpRegisterFailState(error: error.toString()));
    }
  }
}
