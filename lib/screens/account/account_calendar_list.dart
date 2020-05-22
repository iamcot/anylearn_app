import 'dart:math' as math;
import 'package:anylearn/dto/event_dto.dart';
import 'package:anylearn/widgets/calendar_box.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AccountCalendarList extends StatelessWidget {
  final List<EventDTO> events;

  const AccountCalendarList({Key key, this.events}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        events.length > 0
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final itemIndex = index ~/ 2;
                    if (index.isEven) {
                      return ListTile(
                        leading: CalendarBox(text: DateTime.parse(events[itemIndex].date).day.toString()),
                        title: Text(events[itemIndex].title),
                        subtitle:
                            events[itemIndex].content != null ? Text(events[itemIndex].content) : SizedBox(height: 0),
                        trailing: Icon(Icons.arrow_right),
                        onTap: () {
                          Navigator.of(context).pushNamed(events[itemIndex].route);
                        },
                      );
                    }
                    return Divider(
                      height: 0.0,
                    );
                  },
                  semanticIndexCallback: (Widget widget, int localIndex) {
                    if (localIndex.isEven) {
                      return localIndex ~/ 2;
                    }
                    return null;
                  },
                  childCount: math.max(0, events.length * 2 - 1),
                ),
              )
            : SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text.rich(
                    TextSpan(
                      text: "Bạn không có lịch học nào.",
                      style: TextStyle(fontSize: 16.0),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Xem các lịch học đang có",
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushNamed("/event");
                              }),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              )
      ],
    );
  }
}
