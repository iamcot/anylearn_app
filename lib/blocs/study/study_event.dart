part of studybloc;

abstract class StudyEvent {}

class StudyLoadDataEvent extends StudyEvent {
  final String token;
  final int studentID;

  StudyLoadDataEvent({required this.token, required this.studentID});
}