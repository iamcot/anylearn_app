import 'package:equatable/equatable.dart';

class ItemDTO extends Equatable {
  final id;
  String image;
  String type;
  String subtype;
  String title;
  int price;
  int priceOrg;
  String shortContent;
  String content;
  final route;
  final date;
  final rating;
  String dateStart;
  String dateEnd;
  String timeStart;
  String timeEnd;
  final numCart;
  final numShare;
  final numFavorite;
  String location;
  final status;
  final userStatus;
  final authorName;
  final authorType;
  final nolimitTime;
  final openings;
  final url;

  ItemDTO({
    this.id,
    this.image = "",
    this.title = "",
    this.type = "",
    this.subtype = "",
    this.price = 0,
    this.priceOrg = 0,
    this.shortContent = "",
    this.content = "",
    this.route = "",
    this.date = "",
    this.rating = 0.0,
    this.dateStart = "",
    this.dateEnd = "",
    this.timeStart = "",
    this.timeEnd = "",
    this.numCart = 0,
    this.numFavorite = 0,
    this.numShare = 0,
    this.location = "",
    this.status = "",
    this.userStatus = "",
    this.authorName = "",
    this.authorType = "",
    this.nolimitTime = "",
    this.openings = "",
    this.url = "",
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
        nolimitTime,
        openings,
        subtype,
        url,
      ];


  @override
  String toString() => 'ItemDTO {title: $title, type: $type}';

  static ItemDTO fromJson(dynamic json) {
    return json == ""
        ? ItemDTO()
        : ItemDTO(
            title: json['title'] ?? "",
            id: json['id'] ?? 0,
            type: json['type'] ?? "",
            subtype: json['subtype'] ?? "",
            image: json['image']  ?? "",
            price: json['price']  ?? 0,
            priceOrg: json['org_price'] ?? 0,
            shortContent: json['short_content'] ?? "",
            content: json['content'] ?? "",
            rating: json['rating'] == null ? 0.0 : double.parse(json['rating'].toString()),
            dateStart: json['date_start'] ?? "",
            dateEnd: json['date_end'] ?? "",
            timeStart: json['time_start'] ?? "",
            timeEnd: json['time_end'] ?? "",
            numCart: json['num_cart'] ?? "",
            numFavorite: json['num_favorite'] ?? "",
            numShare: json['num_share'] ?? "",
            location: json['location'] ?? "",
            status: json['status'] ?? "",
            url: json['url'] ?? "",
            userStatus: json['user_status'] ?? "",
            authorName: json['author'] ?? "",
            authorType: json['author_type'] ?? "",
            nolimitTime: json['nolimit_time'] == "1" ? true : false,
            openings: json['openings'] == null
                ? []
                : List<ItemDTO>.from(json['openings']?.map((v) => v == null ? null : ItemDTO.fromJson(v))).toList(),
          );
  }
}
