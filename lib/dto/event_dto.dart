import 'package:equatable/equatable.dart';

class EventDTO extends Equatable {
  final int id;
  final String title;
  final String content;
  final String author;
  final String date;
  final String time;
  final String location;
  final String image;
  final String route;

  EventDTO({
    this.id,
    this.content,
    this.author,
    this.date,
    this.title,
    this.time,
    this.location,
    this.image,
    this.route,
  });

  factory EventDTO.fromJson(Map<String, dynamic> json) {
    return EventDTO(
      id: json['id'],
      title: json['title'],
      time: json['time'],
      image: json['image'],
      date: json['date'],
      author: json['author'],
      content: json['content'],
    );
  }

  @override
  List<Object> get props => [id, title, date, time, image, author, content];
}
