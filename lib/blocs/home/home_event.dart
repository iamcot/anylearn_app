part of homebloc;

abstract class HomeEvent {
  const HomeEvent();
}

class LoadHomeEvent extends HomeEvent {
  final UserDTO user;
  LoadHomeEvent({required this.user});
  @override
  String toString() => 'LoadHomeEvent';
}

class LoadQuoteEvent extends HomeEvent {
  final url;
  LoadQuoteEvent({this.url});

  @override
  String toString() => 'LoadQuoteEvent';
}

class LoadGuideEvent extends HomeEvent {
  final String path;
  LoadGuideEvent({required this.path});
  @override
  String toString() => 'LoadGuideEvent';
}

class UpdatePopupVersionEvent extends HomeEvent {
  final int version;
  UpdatePopupVersionEvent({required this.version});
  @override
  String toString() => 'UpdatePopupVersionEvent: $version';
}
