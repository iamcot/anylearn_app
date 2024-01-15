import 'package:equatable/equatable.dart';

class RegisteredCourseDTO extends Equatable {
  final id;
  final title; 
  final author;
  final authorImage;
  final courseImage;
  final student;
  final subtype;
  final confirmed;
  final favorited;
  final rating;
  final startDate;
  final endDate;
  final startTime;
  final endTime;
  final activation;
  final schedule;

  @override
  List<Object?> get props => [
    id,
    title,
    author,
    authorImage,
    courseImage,
    student,
    subtype,
    confirmed,
    favorited,
    rating,
    startDate,
    endDate,
    startTime,
    endTime,
    activation,
    schedule
  ];

  const RegisteredCourseDTO({
    this.id = 0,
    this.title = '',
    this.subtype = '',
    this.author = '',
    this.authorImage = '',
    this.courseImage = '',
    this.student = '',
    this.confirmed = false,
    this.favorited = false,
    this.rating = 0.0,
    this.startDate = '',
    this.endDate = '',
    this.startTime = '',
    this.endTime = '',
    this.activation = '',
    this.schedule = '',
  });

  factory RegisteredCourseDTO.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return RegisteredCourseDTO(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      authorImage: json['author_image'] ?? '',
      courseImage: json['course_image'] ?? '',
      student: json['student'] ?? '',
      subtype: json['subtype'] ?? '',
      confirmed: json['confirmed'] ?? false,
      favorited: json['favorited'] ?? false,
      rating: json['rating'] ?? 0.0,
      startDate: json['date_start'] ?? '',
      endDate: json['date_end'] ?? '',
      startTime: json['time_start'] ?? '',
      endTime: json['time_end'] ?? '',
      activation: json['activation'] != null 
        ? ActivationDTO.fromJson(json['activation']) 
        : [],
      schedule: json['schedule']?.map((scheduleJson) {
        scheduleJson['day_of_week'] ??= '';
        scheduleJson['time_start'] ??= '';
        scheduleJson['time_end'] ??= '';
        return scheduleJson;
      }).toList() ?? [], 
    );
  }
}

class ActivationDTO extends Equatable {
  final username;
  final password;
  final code;
  final link;

  @override
  List<Object?> get props => [
    username,
    password,
    code,
    link,
  ];

  ActivationDTO({
    this.username = '',
    this.password = '',
    this.code = '',
    this.link = '',
  });

  factory ActivationDTO.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return ActivationDTO(
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      code: json['code'] ?? '',
      link: json['link'] ?? '',
    );
  } 
}