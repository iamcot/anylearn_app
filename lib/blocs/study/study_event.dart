part of studybloc;

abstract class StudyEvent {
}

class StudyLoadMainDataEvent extends StudyEvent {
  final UserDTO account;
  final String token;
  StudyLoadMainDataEvent({required this.token, required this.account});
}

class StudyLoadCourseDataEvent extends StudyEvent {
  final String token;
  final int orderItemID;
  StudyLoadCourseDataEvent({required this.token, required this.orderItemID});
}

class StudyLoadScheduleDataEvent extends StudyEvent {
  final String token;
  final String date;
  StudyLoadScheduleDataEvent({required this.token, required this.date});
}