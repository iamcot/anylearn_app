import 'ask_dto.dart';

class AskThreadDTO {
  final AskDTO question;
  final List<AskDTO> comments;
  final List<AskDTO> answers;

  AskThreadDTO({
    this.question,
    this.comments,
    this.answers,
  });

  static AskThreadDTO fromJson(dynamic json) {
    return json == null
        ? null
        : AskThreadDTO(
            question: AskDTO.fromJson(json['question']),
            comments: List<AskDTO>.from(json['comments']?.map((v) => v == null ? null : AskDTO.fromJson(v))).toList(),
            answers: List<AskDTO>.from(json['answers']?.map((v) => v == null ? null : AskDTO.fromJson(v))).toList(),
          );
  }
}
