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
  ArticleIndexSuccessState({@required this.result}) : assert(result != null);
  @override
  List<Object> get props => [result];
}

class ArticleTypeLoadingState extends ArticleState {}

class ArticleTypeSuccessState extends ArticleState {
  final ArticlePagingDTO result;
  ArticleTypeSuccessState({@required this.result}) : assert(result != null);
  @override
  List<Object> get props => [result];
}

class ArticlePageLoadingState extends ArticleState {}

class ArticlePageSuccessState extends ArticleState {
  final ArticleDTO result;
  ArticlePageSuccessState({@required this.result}) : assert(result != null);
  @override
  List<Object> get props => [result];
}

class ArticleFailState extends ArticleState {
  final String error;
  const ArticleFailState({@required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}
