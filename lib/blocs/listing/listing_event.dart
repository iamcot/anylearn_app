part of listingbloc;

abstract class ListingEvent {
  final ListingRouteArguments args;
  ListingEvent({required this.args});
}

class ListingLoadEvent extends ListingEvent {
  ListingLoadEvent({required args}) : super(args: args);
}

class ListingFilterEvent extends ListingEvent {
  ListingFilterEvent({required args}) : super(args: args);
}

class ListingPaginationEvent extends ListingEvent {
  ListingPaginationEvent({required args}) : super(args: args);
}

