import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/dto/v3/registered_item_dto.dart';
import 'package:equatable/equatable.dart';

class StudyDTO extends Equatable { 
  final userInfo;
  final userAccounts;
  final numCourses;
  final ongoingCourses;
  final upcomingCourses;
  final completedCourses;

  @override
  List<Object?> get props => [
    userInfo,
    userAccounts,
    numCourses,
    ongoingCourses,
    upcomingCourses,
    completedCourses,
  ];

  const StudyDTO({
    this.userInfo = '',
    this.userAccounts = '',
    this.numCourses = 0,
    this.ongoingCourses = '',
    this.upcomingCourses = '',
    this.completedCourses = '',
  });

  factory StudyDTO.fromJson(dynamic json) {
    json ??= {};
    return StudyDTO(
      userInfo: json['user_info'] != null ? UserDTO.fromJson(json['user_info']) : {},
      userAccounts: json['user_accounts']
        ?.map((userJson) => UserDTO.fromJson(userJson))
        .toList() ?? [],
      numCourses: json['num_items'] ?? 0,
      ongoingCourses: json['ongoing_items']
        ?.map((itemJson) => RegisteredItemDTO.fromJson(itemJson))
        .toList() ?? [],
      upcomingCourses: json['upcoming_items']
        ?.map((itemJson) => RegisteredItemDTO.fromJson(itemJson))
        .toList() ?? [],
      completedCourses: json['completed_items']
         ?.map((itemJson) => RegisteredItemDTO.fromJson(itemJson))
        .toList() ?? [],
    );
  }
}