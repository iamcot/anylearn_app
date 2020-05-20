import 'dart:math' as math;

import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/dto/users_dto.dart';
import 'package:anylearn/screens/school/school_filter.dart';
import 'package:anylearn/widgets/rating.dart';
import 'package:anylearn/widgets/sliver_banner.dart';
import 'package:flutter/material.dart';

class SchoolBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SchoolBody();
}

class _SchoolBody extends State<SchoolBody> {
  final UsersDTO schoolsData = new UsersDTO(
    banner:
        "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
    list: [
      new UserDTO(
        name: "Trung tâm A",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/items",
        introduce: "Có giới thiệu ngắn",
        rating: 5.0,
      ),
      new UserDTO(
        name: "Trung tâm B có tên siêu dài cần cắt bớt đi cho đẹp",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/items",
        rating: 0.0,
      ),
      new UserDTO(
        name: "Trung tâm C",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/items",
        rating: 0.0,
      ),
      new UserDTO(
        name: "Trung tâm A",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/items",
        introduce: "Có giới thiệu ngắn",
        rating: 0.0,
      ),
      new UserDTO(
        name: "Trung tâm B có tên siêu dài cần cắt bớt đi cho đẹp",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/items",
        rating: 0.0,
      ),
      new UserDTO(
        name: "Trung tâm C",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/items",
        rating: 0.0,
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverBanner(banner: this.schoolsData.banner),
        SchoolFilter(),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final int itemIndex = index ~/ 2;
              if (index.isEven) {
                return ListTile(
                    isThreeLine: true,
                    leading: Container(
                      width: 60.0,
                      height: 60.0,
                      child: Image.network(
                        schoolsData.list[itemIndex].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(schoolsData.list[itemIndex].route);
                    },
                    title: Text(
                      schoolsData.list[itemIndex].name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Icon(Icons.arrow_right),
                    subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      schoolsData.list[itemIndex].introduce != null
                          ? Text(
                              schoolsData.list[itemIndex].introduce,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          : Text(""),
                      RatingBox(
                        score: schoolsData.list[itemIndex].rating,
                        alignment: "start",
                      ),
                    ]));
              }
              return Divider(
                height: 0,
                color: Colors.black12,
              );
            },
            childCount: math.max(0, schoolsData.list.length * 2 - 1),
            semanticIndexCallback: (Widget widget, int localIndex) {
              if (localIndex.isEven) {
                return localIndex ~/ 2;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
