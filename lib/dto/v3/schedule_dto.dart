import 'package:equatable/equatable.dart';

class ScheduleDTO extends Equatable {
  final id;
  final course;
  final author;
  final startTime;
  final endTime;
  final dateOn;
  final locationOn;

  @override
  List<Object?> get props => [
    id,
    course,
    author,
    startTime,
    endTime,
    dateOn,
    locationOn,
  ];

  ScheduleDTO({
    this.id = 0,
    this.course = '',
    this.author = '',
    this.startTime = '',
    this.endTime = '',
    this.dateOn = '',
    this.locationOn = '',
  });

  factory ScheduleDTO.fromJson(dynamic json) {
    json ??= {};
    return ScheduleDTO(
      id: json['id'] ?? 0,
      course: json['course'] ?? '',
      author: json['author'] ?? '',
      startTime: json['time_start'] ?? '',
      endTime: json['time_end'] ?? '',
      dateOn: json['date_on'] ?? '',
      locationOn: json['location_on'] ?? '', 
    );
  }

}