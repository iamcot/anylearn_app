import 'package:equatable/equatable.dart';

import 'event_dto.dart';

class AccountCalendarDTO extends Equatable {
  final List<EventDTO> done;
  final List<EventDTO> open;

  AccountCalendarDTO({this.done, this.open});

  @override
  List<Object> get props => [done, open];

  static AccountCalendarDTO fromJson(json) {
    return json == null
        ? null
        : AccountCalendarDTO(
            done: List<EventDTO>.from(json['done']?.map((e) => e == null ? null : EventDTO.fromJson(e))).toList(),
            open: List<EventDTO>.from(json['open']?.map((e) => e == null ? null : EventDTO.fromJson(e))).toList(),
          );
  }
}
