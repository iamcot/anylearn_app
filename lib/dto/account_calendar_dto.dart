import 'package:equatable/equatable.dart';

import 'event_dto.dart';

class AccountCalendarDTO extends Equatable {
  final List<EventDTO> done;
  final List<EventDTO> open;
  final List<EventDTO> fav;

  AccountCalendarDTO({required this.done, required this.open, required this.fav});

  @override
  List<Object> get props => [done, open, fav];

  static AccountCalendarDTO fromJson(json) {
    return json == ''
        ? AccountCalendarDTO(done: [], open: [], fav: [])
        : AccountCalendarDTO(
            done: List<EventDTO>.from(json['done']?.map((e) => e == null ? null : EventDTO.fromJson(e))).toList(),
            open: List<EventDTO>.from(json['open']?.map((e) => e == null ? null : EventDTO.fromJson(e))).toList(),
            fav: List<EventDTO>.from(json['fav']?.map((e) => e == null ? null : EventDTO.fromJson(e))).toList(),
          );
  }
}
