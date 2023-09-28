
class ListingRouteArguments {
  int page;
  int size;
  bool sortBy;
  String? sort;
  String? search;
  String? subtype;
  String? category;

  ListingRouteArguments({
    this.page = 1,
    this.size = 12,
    this.sortBy = false,
    this.sort,
    this.search,
    this.subtype,
    this.category,
  });

  @override
  String toString() {
    final filter = sort == null ? '' : (sortBy ? '$sort-asc' : '$sort-desc');
    return 'search=$search&sort=$filter&page=$page&size=$size';
  }
}