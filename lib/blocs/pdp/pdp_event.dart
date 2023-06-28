part of pdpbloc;

abstract class PdpEvent{
  const PdpEvent();
}

class LoadPDPEvent extends PdpEvent {
  final int id;
  final String token;

  LoadPDPEvent({required this.id, this.token = ""});
}

class PdpFavoriteTouchEvent extends PdpEvent {
  final int itemId;
  final String token;

  PdpFavoriteTouchEvent({required this.itemId, required this.token});
}

class PdpRegisterEvent extends PdpEvent {
  final int itemId;
  final String token;
  final String voucher;
  final int childUser;

  PdpRegisterEvent({required this.itemId, required this.token, this.voucher = "", this.childUser = 0 });
}

class PdpFriendLoadEvent extends PdpEvent {
  final String token;

  PdpFriendLoadEvent({required this.token});
}

class PdpFriendShareEvent extends PdpEvent {
  final String token;
  final int itemId;
  final List<int> friendIds;
  final bool isALL;

  PdpFriendShareEvent({required this.token, required this.itemId, required this.friendIds, this.isALL = false});
}
