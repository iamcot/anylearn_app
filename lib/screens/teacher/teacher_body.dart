import 'package:anylearn/dto/item_dto.dart';
import 'package:anylearn/screens/teacher/teacher_filter.dart';
import 'package:flutter/material.dart';

class TeacherBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeacherBody();
}

class _TeacherBody extends State<TeacherBody> {
  final List<ItemDTO> teachers = [
    new ItemDTO(
        name: "Giáo viên A",
        title: "MC, Giảng viên",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/teacher",
        shortContent: "Có giới thiệu ngắn"),
    new ItemDTO(
        name: "Tiến sỹ B",
        title: "Giáo viên B có gt siêu dài cần cắt bớt đi cho đẹp",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/teacher"),
    new ItemDTO(
        name: "Giáo viên C",
        title: "MC, Giảng viên",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/teacher",
        shortContent: "Có giới thiệu ngắn"),
    new ItemDTO(
        name: "Giáo viên D",
        title: "MC, Giảng viên",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/teacher",
        shortContent: "Có giới thiệu ngắn"),
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 3;
    return CustomScrollView(
      slivers: <Widget>[
        TeacherFilter(),
        SliverPadding(
          padding: EdgeInsets.all(10.0),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: width,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 0.7,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(teachers[index].route);
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
                                teachers[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5.0),
                            margin: EdgeInsets.only(top: 5.0),
                            child: Text(
                              teachers[index].title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 10.0),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              teachers[index].name,
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
              childCount: teachers.length,
            ),
          ),
        )
      ],
    );
  }
}
