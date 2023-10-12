import 'package:equatable/equatable.dart';

class EventDTO extends Equatable {
  final id;
  final itemId;
  final itemSubtype;
  final title;
  final content;
  final scheduleContent;
  final author;
  final date;
  final time;
  final timeEnd;
  final location;
  final image;
  final route;
  final userJoined;
  final authorStatus;
  final userRating;
  final nolimitTime;
  final childId;
  final childName;
  final itemCode;

  EventDTO({
    this.id,
    this.itemId,
    this.content,
    this.author,
    this.date,
    this.title,
    this.time,
    this.timeEnd,
    this.location,
    this.scheduleContent,
    this.image,
    this.route,
    this.userJoined,
    this.authorStatus,
    this.userRating,
    this.nolimitTime,
    this.childId,
    this.childName,
    this.itemSubtype,
    this.itemCode,
  });

  factory EventDTO.fromJson(Map<String, dynamic> json) {
    return EventDTO(
      id: json['id'],
      itemId: json['item_id'],
      content: json['content'],
      author: json['author'] ?? '',
      date: json['date'],
      title: json['title'],
      time: json['time'],
      timeEnd: json['time_end'],
      location: json['location'],
      scheduleContent: json['schedule_content'],
      image: json['image'],
      route: json['route'] ?? '',
      userJoined: json['user_joined'],
      authorStatus: json['author_status'],
      itemSubtype: json['item_subtype'],
      childId: json['child_id'],
      childName: json['child_name'],
      itemCode: json['item_code'] ?? '********',
      userRating: json['user_rating'] == null ? 0 : int.parse(json['user_rating']),
      nolimitTime: json['nolimit_time'] == null ? false : (json['nolimit_time'] == "1" ? true : false),
    );
  }

  @override
  List<Object> get props => [
    id,
    itemId,
    content,
    author,
    date,
    title,
    time,
    timeEnd,
    location,
    scheduleContent,
    image,
    route,
    userJoined,
    authorStatus,
    userRating,
    nolimitTime,
    childId,
    childName,
    itemSubtype,
    itemCode,
  ];
}

class OnlineScheduleInfoDTO extends Equatable {
  final url;
  final info;

  OnlineScheduleInfoDTO({this.url, this.info});
  @override
  List<Object> get props => throw UnimplementedError();

  factory OnlineScheduleInfoDTO.fromJson(Map<String, dynamic> json) {
    return OnlineScheduleInfoDTO(
      url: json['url'],
      info: json['info'],
    );
  }
}
