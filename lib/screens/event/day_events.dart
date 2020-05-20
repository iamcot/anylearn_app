import 'package:anylearn/dto/event_dto.dart';
import 'package:anylearn/widgets/calendar_box.dart';
import 'package:flutter/material.dart';

class DayEvents extends StatelessWidget {
  final EventDTO eventToday;

  const DayEvents({Key key, this.eventToday}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: eventToday.image.isNotEmpty
              ? BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(eventToday.image),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.2),
                      BlendMode.dstATop,
                    ),
                  ),
                )
              : null,
          child: ListTile(
            trailing: Icon(Icons.arrow_right),
            leading: CalendarBox(text: eventToday.time, fontSize: 12.0),
            title: Text(
              eventToday.title,
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                eventToday.userName,
                style: TextStyle(color: Colors.black87),
              ),
              Text(
                eventToday.content,
                style: TextStyle(color: Colors.black87),
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ]),
            onTap: () {
              Navigator.of(context).pushNamed(eventToday.route);
            },
          ),
        ),
        Divider(height: 5.0, thickness: 1.0, color: Colors.grey[100]),
      ],
    );
  }
}
