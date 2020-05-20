class ItemDTO {
  final int id;
  final String image;
  final String title;
  final double price;
  final double priceOrg;
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
  });
}
