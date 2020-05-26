import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PdpEvent extends Equatable {
  const PdpEvent();
}

class LoadPDPEvent extends PdpEvent {
  final int id;

  LoadPDPEvent({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'LoadPDPEvent  { id: $id}';
}

class PdpFavoriteAddEvent extends PdpEvent {
  final int itemId;
  final int userId;

  PdpFavoriteAddEvent({@required this.itemId, @required this.userId});

  @override
  List<Object> get props => [itemId, userId];

  @override
  String toString() => 'PdpFavoriteAddEvent  { id: $itemId, user: $userId}';
}

class PdpFavoriteRemoveEvent extends PdpEvent {
  final int itemId;
  final int userId;

  PdpFavoriteRemoveEvent({@required this.itemId, @required this.userId});

  @override
  List<Object> get props => [itemId, userId];

  @override
  String toString() => 'PdpFavoriteAddEvent  { id: $itemId, user: $userId}';
}
