class HomeConfigDTO {
  final quoteUrl;
  final bannerRatio;
  final catType;
  final popup;
  late int ignorePopupVersion;

  HomeConfigDTO({this.quoteUrl, this.bannerRatio, this.catType, this.popup});

  static HomeConfigDTO fromJson(dynamic json) {
    return json == null
        ? HomeConfigDTO()
        : HomeConfigDTO(
            quoteUrl: json['quote_url'],
            bannerRatio: double.tryParse(json['banner_ratio']),
            catType: json['cat_type'],
            popup: PopupDTO.fromJson(json['popup']),
          );
  }
}

class PopupDTO {
  final image;
  final route;
  final args;
  final version;

  PopupDTO({this.image, this.route, this.args, this.version});

  static PopupDTO fromJson(dynamic json) {
    return json == ""
        ? PopupDTO()
        : PopupDTO(
            image: json['image'],
            route: json['route'],
            args: json['args'],
            version: json['version'],
          );
  }
}
