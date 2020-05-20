import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/dto/users_dto.dart';
import 'package:anylearn/screens/teacher/teacher_filter.dart';
import 'package:anylearn/widgets/rating.dart';
import 'package:anylearn/widgets/sliver_banner.dart';
import 'package:flutter/material.dart';

class TeacherBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeacherBody();
}

class _TeacherBody extends State<TeacherBody> {
  final UsersDTO teachers = new UsersDTO(
    banner:
        "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
    list: [
      new UserDTO(
        name: "Giáo viên A",
        title: "MC, Giảng viên",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/items",
        introduce: "Có giới thiệu ngắn",
        rating: 5.0,
      ),
      new UserDTO(
        name: "Tiến sỹ B",
        title: "Giáo viên B có gt siêu dài cần cắt bớt đi cho đẹp",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/items",
        rating: 0.0,
      ),
      new UserDTO(
        name: "Giáo viên C",
        title: "MC, Giảng viên",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/items",
        introduce: "Có giới thiệu ngắn",
        rating: 0.0,
      ),
      new UserDTO(
        name: "Giáo viên D",
        title: "MC, Giảng viên",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/items",
        introduce: "Có giới thiệu ngắn",
        rating: 0.0,
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    return CustomScrollView(
      slivers: <Widget>[
        SliverBanner(
          banner: teachers.banner,
        ),
        TeacherFilter(),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: width,
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            childAspectRatio: 0.8,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(teachers.list[index].route);
                },
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.grey[100],
                        width: 1.0,
                      ),
                      bottom: BorderSide(
                        color: Colors.grey[100],
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: width * 3 / 4,
                          child: ClipRRect(
                            child: Image.network(
                              teachers.list[index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5.0),
                          margin: EdgeInsets.only(top: 5.0),
                          child: Text(
                            teachers.list[index].title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 10.0),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            teachers.list[index].name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 5.0),
                          child: RatingBox(score: teachers.list[index].rating),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            childCount: teachers.list.length,
          ),
        ),
      ],
    );
  }
}
