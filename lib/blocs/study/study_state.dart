part of studybloc;

abstract class StudyState extends Equatable {
  @override
  List<Object> get props => [];
}

class StudyInitState extends StudyState {}

class StudyLoadSuccessState extends StudyState {
  final StudyDTO data;

  StudyLoadSuccessState({required this.data});

  @override
  List<Object> get props => [data];
}