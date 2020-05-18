import 'package:anylearn/dto/item_dto.dart';
import 'package:anylearn/screens/school/school_filter.dart';
import 'package:flutter/material.dart';

class SchoolBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SchoolBody();
}

class _SchoolBody extends State<SchoolBody> {
  final List<ItemDTO> schools = [
    new ItemDTO(
        name: "Trung tâm A",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/school",
        shortContent: "Có giới thiệu ngắn"),
    new ItemDTO(
        name: "Trung tâm B có tên siêu dài cần cắt bớt đi cho đẹp",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/school"),
    new ItemDTO(
        name: "Trung tâm C",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/school"),
    new ItemDTO(
        name: "Trung tâm A",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/school",
        shortContent: "Có giới thiệu ngắn"),
    new ItemDTO(
        name: "Trung tâm B có tên siêu dài cần cắt bớt đi cho đẹp",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/school"),
    new ItemDTO(
        name: "Trung tâm C",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/school"),
    new ItemDTO(
        name: "Trung tâm A",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/school",
        shortContent: "Có giới thiệu ngắn"),
    new ItemDTO(
        name: "Trung tâm B có tên siêu dài cần cắt bớt đi cho đẹp",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/school"),
    new ItemDTO(
        name: "Trung tâm C",
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/school"),
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
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
                        schools[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(schools[index].route);
                    },
                    title: Text(
                      schools[index].name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    subtitle: schools[index].shortContent != null
                        ? Text(
                            schools[index].shortContent,
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
            childCount: schools.length,
          ),
        ),
      ],
    );
  }
}
