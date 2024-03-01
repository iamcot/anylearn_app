import 'package:anylearn/dto/v3/registered_item_dto.dart';
import 'package:equatable/equatable.dart';

class CalendarDTO extends Equatable {
  final schedulePlans;
  final currentPlans;
  final lookupDate;

  @override
  List<Object?> get props => [
    schedulePlans,
    currentPlans,
    lookupDate,
  ];

  const CalendarDTO({
    this.schedulePlans = const {},
    this.currentPlans = const [],
    this.lookupDate = '',
  });

  factory CalendarDTO.fromJson(dynamic json) { 
    json ??= {};
    return CalendarDTO(
      lookupDate: json['lookup_date'] != null ? DateTime.parse(json['lookup_date']) : DateTime.now(),
      currentPlans: json['current_plans']?.map((planJson) => RegisteredItemDTO.fromJson(planJson))
        .toList() ?? [],
      schedulePlans: json['schedule_plans'].isNotEmpty 
        ? json['schedule_plans'].map((date, plans) {
            return MapEntry(DateTime.parse(date), plans.map((plan) => RegisteredItemDTO.fromJson(plan)).toList());
          })
        : {},
    );
  }
}