import 'package:anylearn/dto/item_dto.dart';
import 'package:anylearn/widgets/calendar_box.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class WeekCourses extends StatelessWidget {
  final List<ItemDTO> monthCourses;

  const WeekCourses({Key key, this.monthCourses}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final int itemIndex = index ~/ 2;
          if (index.isEven) {
            return ListTile(
              isThreeLine: true,
              leading: CalendarBox(text: DateTime.parse(monthCourses[itemIndex].dateStart).day.toString()),
              onTap: () {
                Navigator.of(context).pushNamed(monthCourses[itemIndex].route);
              },
              title: Text(
                monthCourses[itemIndex].title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Icon(Icons.favorite_border),
              subtitle: monthCourses[itemIndex].shortContent != null
                  ? Text(monthCourses[itemIndex].shortContent, maxLines: 2, overflow: TextOverflow.ellipsis)
                  : Text(""),
            );
          }
          return Divider(
            height: 0,
            color: Colors.grey[200],
          );
        },
        childCount: math.max(0, monthCourses.length * 2 - 1),
        semanticIndexCallback: (Widget widget, int localIndex) {
          if (localIndex.isEven) {
            return localIndex ~/ 2;
          }
          return null;
        },
      ),
    );
  }
}
