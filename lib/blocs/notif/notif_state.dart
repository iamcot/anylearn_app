import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../dto/notification_dto.dart';

abstract class NotifState extends Equatable {
  @override
  List<Object> get props => [];
}

class NotifInitState extends NotifState {}

class NotifLoadingState extends NotifState {}

class NotifSuccessState extends NotifState {
  final NotificationPagingDTO notif;

  NotifSuccessState({@required this.notif}) : assert(notif != null);

  @override
  List<Object> get props => [notif];
}

class NotifReadState extends NotifState {}

class NotifFailState extends NotifState {
  final String error;

  NotifFailState({this.error});

  @override
  List<Object> get props => [error];
}
