import 'package:anylearn/dto/ask_paging_dto.dart';
import 'package:anylearn/dto/ask_thread_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../dto/article_dto.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();
  @override
  List<Object> get props => [];
}

class ArticleInitState extends ArticleState {}

class ArticleIndexLoadingState extends ArticleState {}

class ArticleIndexSuccessState extends ArticleState {
  final ArticleHomeDTO result;
  ArticleIndexSuccessState({required this.result}) : assert(result != null);
  @override
  List<Object> get props => [result];
}

class ArticleTypeLoadingState extends ArticleState {}

class ArticleTypeSuccessState extends ArticleState {
  final ArticlePagingDTO result;
  ArticleTypeSuccessState({required this.result}) : assert(result != null);
  @override
  List<Object> get props => [result];
}

class ArticlePageLoadingState extends ArticleState {}

class ArticlePageSuccessState extends ArticleState {
  final ArticleDTO result;
  ArticlePageSuccessState({required this.result}) : assert(result != null);
  @override
  List<Object> get props => [result];
}

class ArticleFailState extends ArticleState {
  final String error;
  const ArticleFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}

class AskIndexLoadingState extends ArticleState {}

class AskIndexSuccessState extends ArticleState {
  final AskPagingDTO data;
  const AskIndexSuccessState({required this.data});
  @override
  List<Object> get props => [data];
  @override
  String toString() => '{AskIndexSuccessState}';
}

class AskFailState extends ArticleState {
  final String error;
  const AskFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}

class AskThreadLoadingState extends ArticleState {}

class AskThreadSuccessState extends ArticleState {
  final AskThreadDTO data;
  const AskThreadSuccessState({required this.data});
  @override
  List<Object> get props => [data];
  @override
  String toString() => '{AskThreadSuccessState}';
}

class AskCreateLoadingState extends ArticleState {}

class AskCreateSuccessState extends ArticleState {}

class AskCreateFailState extends ArticleState {
  final String error;
  const AskCreateFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}

class AskSelectLoadingState extends ArticleState {}

class AskSelectSuccessState extends ArticleState {}

class AskVoteLoadingState extends ArticleState {}

class AskVoteSuccessState extends ArticleState {}
