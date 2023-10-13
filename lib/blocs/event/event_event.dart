part of eventbloc;

abstract class EventEvent {
  const EventEvent();
}

class LoadEventEvent extends EventEvent {
  final DateTime month;

  LoadEventEvent({required this.month});

  List<Object> get props => [month];

  @override
  String toString() => 'LoadEventEvent';
}