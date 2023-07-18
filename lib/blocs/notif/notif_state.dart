part of notifbloc;

abstract class NotifState extends Equatable {
  @override
  List<Object> get props => [];
}

class NotifInitState extends NotifState {}

class NotifLoadingState extends NotifState {}

class NotifSuccessState extends NotifState {
  final NotificationPagingDTO notif;

  NotifSuccessState({required this.notif}) : assert(notif != null);

  @override
  List<Object> get props => [notif];
}

class NotifReadState extends NotifState {}

class NotifFailState extends NotifState {
  final String error;

  NotifFailState({required this.error});

  @override
  List<Object> get props => [error];
}
