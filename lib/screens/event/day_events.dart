import 'package:anylearn/dto/event_detail.dart';
import 'package:flutter/material.dart';

class DayEvents extends StatelessWidget {
  final EventDetail eventToday;

  const DayEvents({Key key, this.eventToday}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.8),
        borderRadius: BorderRadius.circular(5.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        title: Text(eventToday.title),
        subtitle: Text((eventToday.location != null ? eventToday.time : "") + (eventToday.location != null ? " @" + eventToday.location : "")),
        onTap: null,
      ),
    );
  }
}
