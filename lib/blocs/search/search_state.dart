import 'package:anylearn/dto/item_dto.dart';
import 'package:anylearn/dto/user_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object> get props => [];
}

class SearchInitState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchUserSuccessState extends SearchState {
  final List<UserDTO> users;
  SearchUserSuccessState({@required this.users});
  @override
  List<Object> get props => [users];
}

class SearchItemSuccessState extends SearchState {
  final List<ItemDTO> items;
  SearchItemSuccessState({@required this.items});
  @override
  List<Object> get props => [items];
}

class SearchFailState extends SearchState {
  final String error;
  const SearchFailState({@required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}
