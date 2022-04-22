class ItemUserAction {
  final id;
  final itemId;
  final userId;
  final userName;
  final userImage;
  final value;
  final extraValue;
  final createdAt;

  ItemUserAction({
    this.id,
    this.itemId,
    this.userId,
    this.userName,
    this.userImage,
    this.value,
    this.extraValue,
    this.createdAt,
  });

  static ItemUserAction fromJson(dynamic json) {
    return json == ""
        ? ItemUserAction()
        : ItemUserAction(
            id: json['id'],
            itemId: json['item_id'],
            userId: json['user_id'],
            userName: json['user_name'],
            userImage: json['user_image'],
            value: json['value'],
            extraValue: json['extra_value'],
            createdAt: json['created_at'] == null ? null : DateTime.tryParse(json['created_at']),
          );
  }
}
