part of studybloc;

abstract class StudyEvent {
}

class StudyLoadMainDataEvent extends StudyEvent {
  final String token;
  final int studentID;
  StudyLoadMainDataEvent({required this.token, required this.studentID});
}

class StudyLoadCourseDataEvent extends StudyEvent {
  final String token;
  final int orderItemID;
  StudyLoadCourseDataEvent({required this.token, required this.orderItemID});
}

class StudyLoadScheduleDataEvent extends StudyEvent {
  final String token;
  final String dateOn;
  StudyLoadScheduleDataEvent({required this.token, required this.dateOn});
}