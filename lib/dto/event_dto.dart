class EventDTO {
  final String title;
  final String content;
  final String userName;
  final String date;
  final String time;
  final String location;
  final String image;
  final String route;

  EventDTO({
    this.content,
    this.userName,
    this.date,
    this.title,
    this.time,
    this.location,
    this.image,
    this.route,
  });

  factory EventDTO.fromJson(Map<String, dynamic> json) {
    return EventDTO(
      title: json['title'],
      time: json['time'],
      location: json['location'],
      image: json['image'],
    );
  }
}
