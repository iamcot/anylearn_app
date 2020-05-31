import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../dto/item_dto.dart';
import '../../widgets/calendar_box.dart';

class CourseList extends StatelessWidget {
  final List<ItemDTO> list;
  final shortDayFormat = DateFormat("dd/MM");

  CourseList({Key key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return list.length > 0
        ? ListView.separated(
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                Navigator.of(context).pushNamed("/course/form", arguments: list[index].id);
              },
              leading: CalendarBox(image: list[index].image, fontSize: 12, text: shortDayFormat.format(DateTime.parse(list[index].dateStart))),
              title: Text(list[index].title),
              subtitle: Text(list[index].timeStart + " " + list[index].dateStart, style: TextStyle(
                fontSize: 12
              ),),
              trailing: Icon(Icons.edit, size: 14,),
            ),
            separatorBuilder: (context, index) => Divider(),
            itemCount: list.length,
          )
        : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text.rich(TextSpan(text: "Bạn không có khóa học nào.")),
        );
  }
}
