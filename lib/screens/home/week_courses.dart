import 'package:anylearn/dto/item_dto.dart';
import 'package:anylearn/widgets/calendar_box.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class WeekCourses extends StatelessWidget {
  final List<ItemDTO> monthCourses = [
    new ItemDTO(
      title: "Khóa học nổi bật A",
      date: "2020-05-02",
      image:
          "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
      route: "/teacher",
      shortContent:
          "Thông tin ngắn gọn về khóa học được viết ở dòng để line tự động xuống dòng. dài thêm chút nữa để cắt ba chấm.",
    ),
    new ItemDTO(
      title: "Khóa học nổi bật B có tên siêu dài.",
      date: "2020-05-17",
      image:
          "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
      route: "/teacher",
      shortContent: "Thông tin ngắn gọn về khóa học",
    ),
    new ItemDTO(
      title: "Khóa học nổi bật C",
      date: "2020-05-30",
      image:
          "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
      route: "/teacher",
      shortContent: "Thông tin ngắn gọn về khóa học abc",
    )
  ];
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final int itemIndex = index ~/ 2;
          if (index.isEven) {
            return ListTile(
              isThreeLine: true,
              leading: CalendarBox(text: DateTime.parse(monthCourses[itemIndex].date).day.toString()),
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
