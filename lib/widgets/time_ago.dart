import 'package:flutter/material.dart';

class TimeAgo extends StatelessWidget {
  final DateTime time;

  const TimeAgo({Key key, this.time}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String str;
    DateTime now = DateTime.now();
    if (now.difference(time).inHours < 24) {
      str = now.difference(time).inHours.toString() + " giờ trước";
    } else if (now.difference(time).inDays < 7) {
      str = _vnWeekday(time.weekday) + " lúc " + time.hour.toString() + ":" + time.minute.toString();
    } else {
      str = time.day.toString() + " Th" + time.month.toString() + " lúc " + time.hour.toString() + ":" + time.minute.toString();
    }
    return Text(str, style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic));
  }

  String _vnWeekday(int day) {
    switch (day) {
      case 1:
        return "T.2";
      case 2:
        return "T.3";
      case 3:
        return "T.4";
      case 4:
        return "T.5";
      case 5:
        return "T.6";
      case 6:
        return "T.7";
      case 7:
        return "CN";
    }
    return "";
  }
}
