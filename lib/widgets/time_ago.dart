import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TimeAgo extends StatelessWidget {
  final DateTime time;

  TimeAgo({required this.time});

  @override
  Widget build(BuildContext context) {
    if (time == null) {
      return SizedBox(height: 0);
    }
    return Text(buildTime(time), style: TextStyle(fontSize: 13));
  }

  String buildTime(DateTime _time) {
    String str;
    DateTime now = DateTime.now();
    if (now.difference(_time).inHours <= 1) {
      str = now.difference(_time).inMinutes.toString() + " phút trước".tr();
    } else if (now.difference(_time).inHours < 24) {
      str = now.difference(_time).inHours.toString() + " giờ trước".tr();
    } else if (now.difference(_time).inDays < 7) {
      str = _vnWeekday(_time.weekday) + " lúc " + _time.hour.toString() + ":" + _time.minute.toString();
    } else {
      str = _time.day.toString() +
          " Th" +
          _time.month.toString() +
          " lúc " +
          _time.hour.toString() +
          ":" +
          _time.minute.toString();
    }
    return str;
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
