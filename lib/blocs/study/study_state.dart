part of studybloc;

abstract class StudyState extends Equatable {
  @override
  List<Object> get props => [];
}

class StudyInitState extends StudyState {}

class StudyLoadFailState extends StudyState {
  final String error;
  StudyLoadFailState({this.error = ''});

  @override
  List<Object> get props => [];
}

class StudyLoadSuccessState extends StudyState {
  final StudyDTO data;
  StudyLoadSuccessState({required this.data});

  @override
  List<Object> get props => [data];
}

class StudyLoadCourseSuccessState extends StudyState {
  final RegisteredCourseDTO data;
  StudyLoadCourseSuccessState({required this.data});

  @override
  List<Object> get props => [data];
}

class StudyLoadScheduleSuccessState extends StudyState {
  final List<ScheduleDTO> data;
  StudyLoadScheduleSuccessState({required this.data});

  @override
  List<Object> get props => [data];
}
