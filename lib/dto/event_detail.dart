class EventDetail {
  final String title;
  final String time;
  final String location;
  final String banner;
  final String register;

  EventDetail({this.title, this.time, this.location, this.banner, this.register});

  factory EventDetail.fromJson(Map<String, dynamic> json) {
    return EventDetail(
        title: json['title'],
        time: json['time'],
        location: json['location'],
        banner: json['banner'],
        register: json['register']);
  }
}