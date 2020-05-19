import 'package:anylearn/dto/item_dto.dart';
import 'package:flutter/material.dart';

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
          return Column(
            children: <Widget>[
              ListTile(
                isThreeLine: true,
                leading: Container(
                    width: 50.0,
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/date_bg.png",
                          fit: BoxFit.fitHeight,
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text(
                            DateTime.parse(monthCourses[index].date).day.toString(),
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            ),
                          ),
                        )
                      ],
                    )),
                onTap: () {
                  Navigator.of(context).pushNamed(monthCourses[index].route);
                },
                title: Text(
                  monthCourses[index].title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.favorite_border),
                subtitle: monthCourses[index].shortContent != null
                    ? Text(
                        monthCourses[index].shortContent,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    : Text(""),
              ),
              Divider(
                height: 0,
                color: Colors.grey[300],
              ),
            ],
          );
        },
        childCount: monthCourses.length,
      ),
    );
  }
}
