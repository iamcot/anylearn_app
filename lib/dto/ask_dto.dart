class AskDTO {
  final id;
  final title;
  final type;
  final content;
  final userId;
  final username;
  final userImage;
  final createdAt;
  final selectedAnswer;
  final like;
  final unlike;
  final comments;
  final userRole;
  final myVote;

  AskDTO({
    this.id,
    this.title,
    this.type,
    this.content,
    this.userId,
    this.username,
    this.createdAt,
    this.selectedAnswer,
    this.like,
    this.unlike,
    this.comments,
    this.userImage,
    this.userRole,
    this.myVote,
  });

  static AskDTO fromJson(dynamic json) {
    return json == ""
        ? AskDTO()
        : AskDTO(
            id: json['id'] ?? 0,
            title: json['title'] ?? json['question'] ?? "",
            type: json['type'] ?? "ask",
            content: json['content'] ?? "",
            userId: json['user_id'] ?? 0,
            username: json['name'] ?? "",
            userImage: json['user_image'] ?? "",
            createdAt: json['created_at'] == null ? DateTime.now() : DateTime.parse(json['created_at']),
            selectedAnswer: json['is_selected_answer'] == 0 ? false : true,
            like: json['like'] ?? 0,
            unlike: json['unlike'] ?? 0,
            userRole: json['user_role'] ?? "member",
            myVote: json['my_vote'] ?? 0,
            comments: json['comments'] == null
                ? []
                : List<AskDTO>.from(json['comments']?.map((v) => v == null
                    ? null
                    : AskDTO(
                        id: v['id'] ?? 0,
                        title: v['title'] ?? "",
                        type: v['type'] ?? "ask",
                        content: v['content'] ?? "",
                        userId: v['user_id'] ?? 0,
                        username: v['name'] ?? "",
                        userImage: v['user_image'] ?? "",
                        userRole: v['user_role'] ?? "member",
                        createdAt: v['created_at'] == null ? "" : DateTime.parse(v['created_at']),
                        selectedAnswer: v['is_selected_answer'] == 0 ? false : true,
                        like: v['like'] ?? 0,
                        unlike: v['unlike'] ?? 0,
                        myVote: v['my_vote'] ?? 0,
                      ))).toList(),
          );
  }
}
