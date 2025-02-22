part of usersbloc;

abstract class UsersState extends Equatable {
  const UsersState();
  @override
  List<Object> get props => [];
}

class UsersInitState extends UsersState {}

class UsersLoadingState extends UsersState {}

class UsersSchoolSuccessState extends UsersState {
  final UsersDTO data;
  UsersSchoolSuccessState({required this.data});
  @override
  List<Object> get props => [data];
}

class UsersTeacherSuccessState extends UsersState {
  final UsersDTO data;
  UsersTeacherSuccessState({required this.data});
  @override
  List<Object> get props => [data];
}

class UsersLoadFailState extends UsersState {
  final String error;
  const UsersLoadFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}
