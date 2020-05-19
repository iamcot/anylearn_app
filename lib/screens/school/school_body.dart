import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/dto/users_dto.dart';
import 'package:anylearn/screens/school/school_filter.dart';
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
          introduce: "Có giới thiệu ngắn"),
      new UserDTO(
          name: "Trung tâm B có tên siêu dài cần cắt bớt đi cho đẹp",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/items"),
      new UserDTO(
          name: "Trung tâm C",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/items"),
      new UserDTO(
          name: "Trung tâm A",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/items",
          introduce: "Có giới thiệu ngắn"),
      new UserDTO(
          name: "Trung tâm B có tên siêu dài cần cắt bớt đi cho đẹp",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/items"),
      new UserDTO(
          name: "Trung tâm C",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/items"),
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
              return Column(
                children: <Widget>[
                  ListTile(
                    isThreeLine: true,
                    leading: Container(
                      width: 60.0,
                      height: 60.0,
                      child: Image.network(
                        schoolsData.list[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(schoolsData.list[index].route);
                    },
                    title: Text(
                      schoolsData.list[index].name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    subtitle: schoolsData.list[index].introduce != null
                        ? Text(
                            schoolsData.list[index].introduce,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        : Text(""),
                  ),
                  Divider(
                    height: 0,
                    color: Colors.black12,
                  ),
                ],
              );
            },
            childCount: schoolsData.list.length,
          ),
        ),
      ],
    );
  }
}
