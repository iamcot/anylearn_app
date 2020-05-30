import 'package:equatable/equatable.dart';

class ItemDTO extends Equatable {
  final int id;
  final String image;
  final String title;
  final int price;
  final int priceOrg;
  final String shortContent;
  final String content;
  final String route;
  final String date;
  final double rating;
  final String dateStart;
  final String dateEnd;
  final String timeStart;
  final String timeEnd;
  final int numCart;
  final int numShare;
  final int numFavorite;
  bool isFavorite;
  final String location;

  ItemDTO({
    this.id,
    this.image,
    this.title,
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
  });

  @override
  List<Object> get props => [
        id,
        image,
        title,
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
        location
      ];

  static ItemDTO fromJson(dynamic json) {
    return json == null
        ? null
        : ItemDTO(
            title: json['title'],
            id: json['id'],
            image: json['image'],
            price: json['price'],
            priceOrg: json['org_price'],
            shortContent: json['short_content'],
            content: json['content'],
            rating: json['rating'],
            dateStart: json['date_start'],
            dateEnd: json['date_end'],
            timeStart: json['time_start'],
            numCart: json['num_cart'],
            numFavorite: json['num_favorite'],
            numShare: json['num_share'],
            location: json['location'],
          );
  }
}
