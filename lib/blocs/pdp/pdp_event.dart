import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PdpEvent extends Equatable {
  const PdpEvent();
}

class LoadPDPEvent extends PdpEvent {
  final int id;
  final String token;

  LoadPDPEvent({required this.id, this.token = ""});

  @override
  List<Object> get props => [id, token];

  @override
  String toString() => 'LoadPDPEvent  { id: $id}';
}

class PdpFavoriteTouchEvent extends PdpEvent {
  final int itemId;
  final String token;

  PdpFavoriteTouchEvent({required this.itemId, required this.token});

  @override
  List<Object> get props => [itemId, token];

  @override
  String toString() => 'PdpFavoriteTouchEvent  { id: $itemId}';
}

class PdpRegisterEvent extends PdpEvent {
  final int itemId;
  final String token;
  final String voucher;
  final int childUser;

  PdpRegisterEvent({required this.itemId, required this.token, this.voucher = "", this.childUser = 0 });

  @override
  List<Object> get props => [itemId, token, voucher];

  @override
  String toString() => 'PdpRegisterEvent  { id: $itemId, voucher: $voucher}';
}

class PdpFriendLoadEvent extends PdpEvent {
  final String token;

  PdpFriendLoadEvent({required this.token});

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

  PdpFriendShareEvent({required this.token, required this.itemId, required this.friendIds, this.isALL = false});

  @override
  List<Object> get props => [token, itemId, friendIds, isALL];

  @override
  String toString() => 'PdpFriendShareEvent {id: $itemId, friends: $friendIds, isALL: $isALL}';
}
