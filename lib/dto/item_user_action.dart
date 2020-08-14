class ItemUserAction {
  final int id;
  final int itemId;
  final int userId;
  final String userName;
  final String userImage;
  final String value;
  final String extraValue;
  final DateTime createdAt;

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
    return json == null
        ? null
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
