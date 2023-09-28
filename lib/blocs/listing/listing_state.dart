part of listingbloc;

abstract class ListingState extends Equatable {
  // Pagination
  final ListingDTO? data;
  final bool hasReached; 

  // Filter
  final String? sort;
  final bool sortBy; 

  ListingState({this.data, this.hasReached = false, this.sort, this.sortBy = false});

  @override
  List<Object?> get props => [data, hasReached, sort, sortBy];
}

class ListingInitState extends ListingState {}

class ListingLoadFailState extends ListingState {}

class ListingLoadSuccessState extends ListingState {
  ListingLoadSuccessState({data, hasReached = false, sort, sortBy = false}) 
    : super(data: data, hasReached: hasReached, sort: sort, sortBy: sortBy);

  @override
  List<Object?> get props => [data, sort, sortBy, hasReached];
}

