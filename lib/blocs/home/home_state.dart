part of homebloc;

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class QuoteLoadingState extends HomeState {}

class QuoteSuccessState extends HomeState {
  final QuoteDTO quote;

  QuoteSuccessState({required this.quote});
  @override
  List<Object> get props => [quote];
}

class QuoteFailState extends HomeState {}

class HomeSuccessState extends HomeState {
  final HomeV3DTO data;
  HomeSuccessState({required this.data});
  @override
  List<Object> get props => [data];
}

class HomeFailState extends HomeState {
  final String error;
  const HomeFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}

class GuideLoadingState extends HomeState {}

class GuideFailState extends HomeState {
  final String error;
  const GuideFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}

class GuideLoadSuccessState extends HomeState {
  final DocDTO doc;

  GuideLoadSuccessState({required this.doc});
  @override
  List<Object> get props => [doc];
  @override
  String toString() => 'GuideLoadSuccessState';
}

class UpdatePopupSuccessState extends HomeState {}
