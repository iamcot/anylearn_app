class ListingRouteArguments {
  int page;
  int size;
  bool sortBy;
  String sort;
  String search;
  String subtype;
  String category;

  ListingRouteArguments({
    this.page = 1,
    this.size = 12,
    this.sortBy = true,
    this.sort = 'hot',
    this.search = '',
    this.subtype = '',
    this.category = '',
  });

  @override
  String toString() {
    final filter = sortBy ? '$sort-asc' : '$sort-desc';
    return 'search=$search&category=$category&sort=$filter&page=$page&size=$size';
  }

  @override 
  ListingRouteArguments.clone(ListingRouteArguments obj) 
    : this(
      search: obj.search, 
      subtype: obj.subtype, 
      category: obj.category, 
      sortBy: obj.sortBy,
      sort: obj.sort,
    );
}