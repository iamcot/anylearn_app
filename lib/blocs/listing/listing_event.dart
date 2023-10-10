part of listingbloc;

abstract class ListingEvent {
  final ListingRouteArguments? args;
  ListingEvent({this.args});
}

class ListingLoadEvent extends ListingEvent {
  ListingLoadEvent({required args}) : super(args: args);
}

class ListingFilterEvent extends ListingEvent {
  final String sort;
  ListingFilterEvent({required this.sort});
}

class ListingLoadMoreEvent extends ListingEvent {}