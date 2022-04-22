import 'event_dto.dart';

class EventsDTO {
  final events;

  EventsDTO({this.events});

  factory EventsDTO.fromJson(Map<String, dynamic> json) {
    return EventsDTO(
      events: (json).map(
        (k, e) => new MapEntry(
          k,
          e == null
              ? null
              : (e as List).map((f) => f == null ? null : new EventDTO.fromJson(f as Map<String, dynamic>)).toList(),
        ),
      ),
    );
  }
}
