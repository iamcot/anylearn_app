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

class PdpRegisterEvent extends PdpEvent {
  final int itemId;
  final String token;

  PdpRegisterEvent({@required this.itemId, @required this.token});

  @override
  List<Object> get props => [itemId, token];

  @override
  String toString() => 'PdpRegisterEvent  { id: $itemId}';
}

class PdpFriendLoadEvent extends PdpEvent {
  final String token;

  PdpFriendLoadEvent({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'PdpFriendLoadEvent';
}

class PdpFriendShareEvent extends PdpEvent {
  final String token;
  final int itemId;
  final List<int> friendIds;
  final bool isALL;

  PdpFriendShareEvent({this.token, this.itemId, this.friendIds, this.isALL});

  @override
  List<Object> get props => [token, itemId, friendIds, isALL];

  @override
  String toString() => 'PdpFriendShareEvent {id: $itemId, friends: $friendIds, isALL: $isALL}';
}
