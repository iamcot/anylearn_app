import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class FeedbackState extends Equatable {
  const FeedbackState();
  @override
  List<Object> get props => [];
}

class FeedbackInitState extends FeedbackState {}

class FeedbackSavingState extends FeedbackState {}

class FeedbackSuccessState extends FeedbackState {
  final bool result;
  FeedbackSuccessState({@required this.result}) : assert(result != null);
  @override
  List<Object> get props => [result];
}

class FeedbackFailState extends FeedbackState {
  final String error;
  const FeedbackFailState({@required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}
