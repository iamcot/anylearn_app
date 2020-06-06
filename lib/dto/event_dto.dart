import 'package:equatable/equatable.dart';

class EventDTO extends Equatable {
  final int id;
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

  EventDTO({
    this.id,
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
  });

  factory EventDTO.fromJson(Map<String, dynamic> json) {
    return EventDTO(
      id: json['id'],
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
    );
  }

  @override
  List<Object> get props => [id, title, date, time, image, author, content, userJoined, location, authorStatus];
}
