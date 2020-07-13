import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class NotifEvent extends Equatable {
  const NotifEvent();

  @override
  List<Object> get props => [];
}

class NotifLoadEvent extends NotifEvent {
  final String token;
  NotifLoadEvent({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'NotifLoadEvent';
}


class NotifReadEvent extends NotifEvent {
  final String token;
  final int id;
  const NotifReadEvent({@required this.token, this.id, });

  @override
  List<Object> get props => [token, id];

  @override
  String toString() => 'NotifReadEvent id: $id';
}
