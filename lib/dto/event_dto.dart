import 'package:equatable/equatable.dart';

class EventDTO extends Equatable {
  final int id;
  final int itemId;
  final String title;
  final String content;
  final String author;
  final String date;
  final String time;
  final String timeEnd;
  final String location;
  final String image;
  final String route;
  final int userJoined;
  final int authorStatus;
  final int userRating;
  final bool nolimitTime;
  final int childId;
  final String childName;

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
    this.image,
    this.route,
    this.userJoined,
    this.authorStatus,
    this.userRating,
    this.nolimitTime,
    this.childId,
    this.childName,
  });

  factory EventDTO.fromJson(Map<String, dynamic> json) {
    return EventDTO(
      id: json['id'],
      itemId: json['item_id'],
      title: json['title'],
      time: json['time'],
      timeEnd: json['time_end'],
      image: json['image'],
      date: json['date'],
      author: json['author'],
      content: json['content'],
      userJoined: json['user_joined'],
      location: json['location'],
      authorStatus: json['author_status'],
      childId: json['child_id'],
      childName: json['child_name'],
      userRating: json['user_rating'] == null ? 0 : int.parse(json['user_rating']),
      nolimitTime: json['nolimit_time'] == null ? false : (json['nolimit_time'] == "1" ? true : false),
    );
  }

  @override
  List<Object> get props => [
        id,
        title,
        date,
        time,
        image,
        author,
        content,
        userJoined,
        location,
        authorStatus,
        itemId,
        childId,
        childName,
      ];
}
