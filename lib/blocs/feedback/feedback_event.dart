import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent();
}

class SaveFeedbackEvent extends FeedbackEvent {
  final String token;
  final String content;
  final File file;

  SaveFeedbackEvent({required this.token, required this.content, required this.file});
  @override
  List<Object> get props => [token, content, file];

  @override
  String toString() => 'SaveFeedbackEvent {content: $content, file: $file}';
}
