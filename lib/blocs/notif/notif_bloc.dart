library notifbloc;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../dto/notification_dto.dart';
import '../../models/user_repo.dart';

part 'notif_event.dart';
part 'notif_state.dart';

class NotifBloc extends Bloc<NotifEvent, NotifState> {
  final UserRepository userRepository;

  NotifBloc({required this.userRepository}) : super(NotifInitState()) {
    on<NotifLoadEvent>(_onNotifLoadEvent);
    on<NotifReadEvent>(_onNotifReadEvent);
  }
  
  void _onNotifLoadEvent(NotifLoadEvent event, Emitter<NotifState> emit) async {
    try {
      emit(NotifLoadingState());
      final notifs = await userRepository.notification(event.token);
      emit(NotifSuccessState(notif: notifs));
    } catch (error) {
      emit(NotifFailState(error: error.toString()));
    }
  }

  void _onNotifReadEvent(NotifReadEvent event, Emitter<NotifState> emit) async {
    try {
      await userRepository.notifRead(event.token, event.id);
      emit(NotifReadState());
    } catch (error) {
      emit(NotifFailState(error: error.toString()));
    }
  }

  /*@override
  NotifState get initialState => NotifInitState();

  @override
  Stream<NotifState> mapEventToState(NotifEvent event) async* {
    try {
      if (event is NotifLoadEvent) {
        yield NotifLoadingState();
        final notifs = await userRepository.notification(event.token);
        yield NotifSuccessState(notif: notifs);
      } else if (event is NotifReadEvent) {
        await userRepository.notifRead(event.token, event.id);
        yield NotifReadState();
      }
    } catch (error) {
      yield NotifFailState(error: error.toString());
    }
  }*/
}
