part of notifbloc;

abstract class NotifEvent {
  const NotifEvent();
}

class NotifLoadEvent extends NotifEvent {
  final String token;
  NotifLoadEvent({required this.token});

  @override
  String toString() => 'NotifLoadEvent';
}


class NotifReadEvent extends NotifEvent {
  final String token;
  final int id;
  const NotifReadEvent({required this.token, required this.id, });

  @override
  String toString() => 'NotifReadEvent id: $id';
}
