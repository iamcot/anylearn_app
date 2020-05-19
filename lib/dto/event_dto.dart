class EventDTO {
  final String title;
  final String time;
  final String location;
  final String banner;
  final String register;

  EventDTO({this.title, this.time, this.location, this.banner, this.register});

  factory EventDTO.fromJson(Map<String, dynamic> json) {
    return EventDTO(
        title: json['title'],
        time: json['time'],
        location: json['location'],
        banner: json['banner'],
        register: json['register']);
  }
}