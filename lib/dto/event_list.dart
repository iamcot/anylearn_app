import 'event_detail.dart';

class EventList {
  final Map<String, List<EventDetail>> eventList;

  EventList({this.eventList});

  factory EventList.fromJson(Map<String, dynamic> json) {
    return EventList(
        eventList: (json)?.map((k, e) => new MapEntry(
            k,
            e == null
                ? null
                : (e as List)
                    ?.map((f) => f == null ? null : new EventDetail.fromJson(f as Map<String, dynamic>))
                    ?.toList())));
  }
}
