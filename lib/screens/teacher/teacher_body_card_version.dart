import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/dto/users_dto.dart';
import 'package:anylearn/screens/teacher/teacher_filter.dart';
import 'package:anylearn/widgets/sliver_banner.dart';
import 'package:flutter/material.dart';

class TeacherCardVersionBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeacherCardVersionBody();
}

class _TeacherCardVersionBody extends State<TeacherCardVersionBody> {
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
          introduce: "Có giới thiệu ngắn"),
      new UserDTO(
          name: "Tiến sỹ B",
          title: "Giáo viên B có gt siêu dài cần cắt bớt đi cho đẹp",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/items"),
      new UserDTO(
          name: "Giáo viên C",
          title: "MC, Giảng viên",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/items",
          introduce: "Có giới thiệu ngắn"),
      new UserDTO(
          name: "Giáo viên D",
          title: "MC, Giảng viên",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/items",
          introduce: "Có giới thiệu ngắn"),
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
        SliverPadding(
          padding: EdgeInsets.all(10.0),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: width,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              childAspectRatio: 0.8,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(teachers.list[index].route);
                  },
                  child: Card(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: width * 3 / 4,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.only(topLeft: Radius.circular(7.0), topRight: Radius.circular(7.0)),
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
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: teachers.list.length,
            ),
          ),
        )
      ],
    );
  }
}
