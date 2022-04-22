import 'package:anylearn/dto/event_dto.dart';
import 'package:anylearn/widgets/calendar_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DayEvents extends StatelessWidget {
  final EventDTO eventToday;

  const DayEvents({key, required this.eventToday}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: eventToday.image != null
              ? BoxDecoration(
                  image: DecorationImage(
                    image:CachedNetworkImageProvider(eventToday.image),
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
            leading: eventToday.time == null ? Icon(Icons.calendar_today) :CalendarBox(text: eventToday.time, fontSize: 12.0),
            title: Text(
              eventToday.title,
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                eventToday.author,
                style: TextStyle(color: Colors.black87),
              ),
              eventToday.content != null ? Text(
                eventToday.content,
                style: TextStyle(color: Colors.black87),
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ) : Text(""),
            ]),
            onTap: () {
              Navigator.of(context).pushNamed("/pdp", arguments: eventToday.itemId);
            },
          ),
        ),
        Divider(height: 5.0, thickness: 1.0, color: Colors.grey[100]),
      ],
    );
  }
}
