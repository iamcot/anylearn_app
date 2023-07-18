part of itemsbloc;

abstract class ItemsState extends Equatable {
  const ItemsState();
  @override
  List<Object> get props => [];
}

class ItemsInitState extends ItemsState {}

class ItemsLoadingState extends ItemsState {}

class ItemsSchoolSuccessState extends ItemsState {
  final ItemsDTO data;
  ItemsSchoolSuccessState({required this.data}) : assert(data != null);
  @override
  List<Object> get props => [data];
}

class ItemsTeacherSuccessState extends ItemsState {
  final ItemsDTO data;
  ItemsTeacherSuccessState({required this.data}) : assert(data != null);
  @override
  List<Object> get props => [data];
}

class ItemsLoadFailState extends ItemsState {
  final String error;
  const ItemsLoadFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}

class CategoryLoadingState extends ItemsState {}

class CategorySuccessState extends ItemsState {
  final List<CategoryPagingDTO> data;
  CategorySuccessState({required this.data}) : assert(data != null);
  @override
  List<Object> get props => [data];
}

class CategoryFailState extends ItemsState {
  final String error;
  const CategoryFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}
