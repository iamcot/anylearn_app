part of feedbackbloc;

abstract class FeedbackEvent {
  const FeedbackEvent();
}

class SaveFeedbackEvent extends FeedbackEvent {
  final String token;
  final String content;
  final File file;

  SaveFeedbackEvent({required this.token, required this.content, required this.file});

  List<Object> get props => [token, content, file];

  @override
  String toString() => 'SaveFeedbackEvent {content: $content, file: $file}';
}
