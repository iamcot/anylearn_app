part of listingbloc;

abstract class ListingState extends Equatable {
  final ListingRouteArguments? args;
  final ListingDTO? data;
  final bool isRerender;

  ListingState({this.args, this.data, this.isRerender = false});

  @override
  List<Object?> get props => [args, data];

  bool get hasReachedMax =>  data!.currentPage + 1 > data!.numPage; 
}

class ListingInitState extends ListingState {}

class ListingLoadFailState extends ListingState {}

class ListingLoadSuccessState extends ListingState {
  ListingLoadSuccessState({args, data, isRerender = false}) 
    : super(args: args, data: data, isRerender: isRerender);
}

