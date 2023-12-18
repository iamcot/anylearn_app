import 'package:anylearn/dto/v3/registered_courses_dto.dart';
import 'package:equatable/equatable.dart';

class StudyDTO extends Equatable { 
  final studentID;
  final studentImage;
  final studentList;
  final numCourses;
  final upcomingCourses;
  final scheduleCourses;
  final doneCourses;

  @override
  List<Object?> get props => [
    studentID,
    studentImage,
    studentList, 
    numCourses, 
    upcomingCourses, 
    scheduleCourses, 
    doneCourses
  ];

  const StudyDTO({
    this.studentID,
    this.studentImage,
    this.studentList,
    this.numCourses = 0,
    this.doneCourses = const [],
    this.upcomingCourses = const [],
    this.scheduleCourses = const [],
  });

  factory StudyDTO.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return StudyDTO(
      studentID: json['student_id'] ?? 0,
      numCourses: json['num_courses'] ?? 0,
      studentImage: json['student_image'] ?? '',
      studentList: json['student_list']
        ?.map((studentJson) => studentJson)
        .toList() ?? [],
      upcomingCourses: json['upcoming_courses']
        ?.map((courseJson) => RegisteredCourseDTO.fromJson(courseJson as Map<String, dynamic>))
        .toList() ?? [],
      scheduleCourses: json['schedule_courses']
        ?.map((courseJson) => RegisteredCourseDTO.fromJson(courseJson as Map<String, dynamic>))
        .toList() ?? [],
      doneCourses: json['done_courses']
        ?.map((courseJson) => RegisteredCourseDTO.fromJson(courseJson as Map<String, dynamic>))
        .toList() ??
        [],
    );
  }
}