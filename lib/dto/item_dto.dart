import 'package:equatable/equatable.dart';

class ItemDTO extends Equatable {
  final int id;
  String image;
  String type;
  String title;
  int price;
  int priceOrg;
  String shortContent;
  String content;
  final String route;
  final String date;
  final double rating;
  String dateStart;
  String dateEnd;
  String timeStart;
  String timeEnd;
  final int numCart;
  final int numShare;
  final int numFavorite;
  bool isFavorite;
  String location;
  final int status;
  final int userStatus;
  final String authorName;
  final String authorType;

  ItemDTO({
    this.id,
    this.image,
    this.title,
    this.type,
    this.price,
    this.priceOrg,
    this.shortContent,
    this.content,
    this.route,
    this.date,
    this.rating,
    this.dateStart,
    this.dateEnd,
    this.timeStart,
    this.timeEnd,
    this.numCart,
    this.numFavorite,
    this.numShare,
    this.location,
    this.status,
    this.userStatus,
    this.authorName,
    this.authorType,
  });

  @override
  List<Object> get props => [
        id,
        image,
        title,
        type,
        price,
        priceOrg,
        shortContent,
        content,
        date,
        rating,
        dateStart,
        dateEnd,
        timeStart,
        numCart,
        numFavorite,
        numShare,
        location,
        status,
        userStatus,
        authorName,
        authorType,
      ];

  @override
  String toString() => 'ItemDTO {title: $title, type: $type}';

  static ItemDTO fromJson(dynamic json) {
    return json == null
        ? null
        : ItemDTO(
            title: json['title'],
            id: json['id'],
            type: json['type'],
            image: json['image'],
            price: json['price'],
            priceOrg: json['org_price'],
            shortContent: json['short_content'],
            content: json['content'],
            rating: json['rating'],
            dateStart: json['date_start'],
            dateEnd: json['date_end'],
            timeStart: json['time_start'],
            timeEnd: json['time_end'],
            numCart: json['num_cart'],
            numFavorite: json['num_favorite'],
            numShare: json['num_share'],
            location: json['location'],
            status: json['status'],
            userStatus: json['user_status'],
            authorName: json['author'] ?? null,
            authorType: json['author_type'] ?? null,
          );
  }
}
