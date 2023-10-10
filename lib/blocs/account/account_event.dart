part of accountbloc;

abstract class AccountEvent {
  const AccountEvent();
}

class AccInitPageEvent extends AccountEvent {
  final UserDTO user;

  AccInitPageEvent({required this.user});

  @override
  String toString() => 'AccInitPageEvent $user';
}

class AccChangeAvatarEvent extends AccountEvent {
  final File file;
  final String token;

  AccChangeAvatarEvent({required this.token, required this.file});
 
  @override
  String toString() => 'AccChangeAvatarEvent';
}

class AccChangeBannerEvent extends AccountEvent {
  final File file;
  final String token;

  AccChangeBannerEvent({required this.token, required this.file});

  @override
  String toString() => 'AccChangeBannerEvent';
}

class AccEditSubmitEvent extends AccountEvent {
  final UserDTO user;
  final String token;

  AccEditSubmitEvent({required this.user, required this.token});

  @override
  String toString() => 'AccEditSubmitEvent $user';
}

class AccLoadFriendsEvent extends AccountEvent {
  final int userId;
  final String token;

  AccLoadFriendsEvent({required this.userId, required this.token});

  @override
  String toString() => 'AccLoadFriendsEvent $userId';
}

class AccLoadMyCalendarEvent extends AccountEvent {
  final String token;

  AccLoadMyCalendarEvent({required this.token});

  @override
  String toString() => 'AccLoadMyCalendarEvent';
}

class AccJoinCourseEvent extends AccountEvent {
  final String token;
  final int scheduleId;
  final int itemId;
  final int childId;

  AccJoinCourseEvent({required this.token, required this.itemId, required this.scheduleId, required this.childId});
 
  @override
  String toString() => 'AccJoinCourseEvent $itemId $childId';
}

class AccProfileEvent extends AccountEvent {
  final int userId;

  AccProfileEvent({required this.userId});

  @override
  String toString() => 'AccProfileEvent $userId';
}

class AccLoadDocsEvent extends AccountEvent {
  final String token;

  AccLoadDocsEvent({required this.token});

  @override
  String toString() => 'AccLoadDocsEvent';
}

class AccAddDocEvent extends AccountEvent {
  final String token;
  final File file;

  AccAddDocEvent({required this.token, required this.file});

  @override
  String toString() => 'AccAddDocEvent';
}

class AccRemoveDocEvent extends AccountEvent {
  final String token;
  final int fileId;

  AccRemoveDocEvent({required this.token, required this.fileId});
  @override
  String toString() => 'AccRemoveDocEvent $fileId';
}

class AccSaveChildrenEvent extends AccountEvent {
  final String token;
  final String name;
  final int id;
  final String dob;

  AccSaveChildrenEvent({required this.token, required this.id, required this.name, required this.dob});

  @override
  String toString() => 'AccSaveChildrenEvent $id, $name, $dob';
}

class AccLoadChildrenEvent extends AccountEvent {
  final String token;

  AccLoadChildrenEvent({required this.token});

  @override
  String toString() => 'AccLoadChildrenEvent';
}

class AccChangePassEvent extends AccountEvent {
  final String newPass;
  final String oldPass;
  final String token;

  AccChangePassEvent({required this.newPass, required this.oldPass, required this.token});

  @override
  String toString() => 'AccChangePassEvent';
}
