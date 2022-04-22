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
            id: json['id'],
            title: json['title'] ?? "",
            type: json['type'],
            content: json['content'],
            userId: json['user_id'],
            username: json['name'],
            userImage: json['user_image'],
            createdAt: DateTime.parse(json['created_at']),
            selectedAnswer: json['is_selected_answer'] == 0 ? false : true,
            like: json['like'],
            unlike: json['unlike'],
            userRole: json['user_role'],
            myVote: json['my_vote'],
            comments: json['comments'] == null
                ? []
                : List<AskDTO>.from(json['comments']?.map((v) => v == null
                    ? null
                    : AskDTO(
                        id: v['id'],
                        title: v['title'] ?? "",
                        type: v['type'],
                        content: v['content'],
                        userId: v['user_id'],
                        username: v['name'],
                        userImage: v['user_image'],
                        userRole: v['user_role'],
                        createdAt: DateTime.parse(v['created_at']),
                        selectedAnswer: v['is_selected_answer'] == 0 ? false : true,
                        like: v['like'],
                        unlike: v['unlike'],
                        myVote: v['my_vote'],
                      ))).toList(),
          );
  }
}
