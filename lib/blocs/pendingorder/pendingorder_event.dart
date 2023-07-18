part of pendingorderbloc;

abstract class PendingOrderEvent {
  const PendingOrderEvent();
}

class LoadPendingorderPageEvent extends PendingOrderEvent {
  final String token;

  LoadPendingorderPageEvent({required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoadTransactionPageEvent {token: $token}  ';
}
