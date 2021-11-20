import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../models/user_repo.dart';
import 'notif_blocs.dart';

class NotifBloc extends Bloc<NotifEvent, NotifState> {
  final UserRepository userRepository;

  NotifBloc({@required this.userRepository}) : assert(userRepository != null), super(null);

  @override
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
  }
}
