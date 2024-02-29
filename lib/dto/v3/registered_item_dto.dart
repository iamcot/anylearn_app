import 'package:equatable/equatable.dart';

class RegisteredItemDTO extends Equatable {
  final id;
  final title; 
  final image;
  final author;
  final authorID;
  final student;
  final subtype;
  final favorited;
  final rating;
  final reviews;
  final plan;
  final planInfo;
  final weekdays;
  final startDate;
  final endDate;
  final startTime;
  final endTime;
  final organizerConfirm;
  final participantConfirm;
  final activationInfo;
  final orderItemID;
  final purchasedAt;
  final location;

  @override
  List<Object?> get props => [
    id,
    title,
    image,
    author,
    authorID,
    student,
    subtype,
    favorited,
    rating,
    reviews,
    plan,
    planInfo,
    weekdays,
    startDate,
    endDate,
    startTime,
    endTime,
    organizerConfirm,
    participantConfirm,
    activationInfo,
    orderItemID,
    purchasedAt,
    location,
  ];

  const RegisteredItemDTO({
    this.id = 0,
    this.title = '',
    this.image = '',
    this.author = '',
    this.authorID = 0,
    this.student = '',
    this.subtype = '',
    this.rating = 0.0,
    this.reviews = 0,
    this.plan = '',
    this.planInfo = '',
    this.weekdays = '',
    this.startDate = '',
    this.endDate = '',
    this.startTime = '',
    this.endTime = '',
    this.favorited = 0,
    this.organizerConfirm = 0,
    this.participantConfirm = 0,
    this.activationInfo = '',
    this.orderItemID = 0,
    this.purchasedAt = '',
    this.location = '',
  });

  factory RegisteredItemDTO.fromJson(dynamic json) {
    json ??= {};
    return RegisteredItemDTO(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      author: json['author'] ?? '',
      authorID: json['author_id'] ?? 0,
      student: json['student'] ?? '',
      subtype: json['subtype'] ?? '',
      rating: json['rating'] == null ? 0.0 : double.parse(json['rating'].toString()),
      reviews: json['reviews'] ?? 0,
      plan: json['plan'] ?? '',
      planInfo: json['plan_info'] ?? '',
      weekdays: json['weekdays'] ?? '',
      startDate: json['date_start'] ?? '',
      endDate: json['date_end'] ?? '',
      startTime: json['time_start'] ?? '',
      endTime: json['time_end'] ?? '',
      favorited: null != json['favorited'] ? int.parse(json['favorited']) : 0,
      orderItemID: json['order_item_id'] ?? 0,
      purchasedAt: json['purchased_at'] ?? '',
      organizerConfirm: json['organizer_confirm'] ?? 0,
      participantConfirm: json['participant_confirm'] ?? 0,
      activationInfo: json['activation_info']?.map((key, value) => MapEntry(key, value ?? '')) ?? {},
      location: json['location'] ?? '',
    );
  }
}
