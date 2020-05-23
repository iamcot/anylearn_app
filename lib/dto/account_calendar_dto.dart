import 'event_dto.dart';

class AccountCalendarDTO {
  final List<EventDTO> done;
  final List<EventDTO> thisMonth;
  final List<EventDTO> later;

  AccountCalendarDTO({this.done, this.thisMonth, this.later});
}