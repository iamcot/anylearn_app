part of subtypebloc;

abstract class SubtypeEvent {
  const SubtypeEvent();
}

class LoadSubtypePageEvent extends SubtypeEvent {
  final String category;
  final String token;
  
  LoadSubtypePageEvent({required this.category, this.token = ''});
}
