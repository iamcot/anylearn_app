import 'package:equatable/equatable.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();
}

class LoadEventEvent extends EventEvent {
  final DateTime month;

  LoadEventEvent({this.month});
  @override
  List<Object> get props => [month];

  @override
  String toString() => 'LoadEventEvent';
}