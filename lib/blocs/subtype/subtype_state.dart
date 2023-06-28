part of subtypebloc;

abstract class SubtypeState extends Equatable {
  @override
  List<Object> get props => [];
}

class SubtypeInitState extends SubtypeState {}
class SubtypeSuccessState extends SubtypeState {
  final SubtypeDTO data;
  SubtypeSuccessState({required this.data});
  @override
  List<Object> get props => [data];
}

class SubtypeFailState extends SubtypeState {
  final error;
  SubtypeFailState({required this.error});
  @override
  List<Object> get props => [error];
}
