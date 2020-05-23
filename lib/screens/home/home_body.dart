import 'package:flutter/material.dart';

import '../../dto/hot_items_dto.dart';
import '../../dto/item_dto.dart';
import '../../dto/user_dto.dart';
import 'appbar.dart';
import 'banner.dart';
import 'features.dart';
import 'hot_items.dart';
import 'week_courses.dart';
import 'week_courses_header.dart';

class HomeBody extends StatelessWidget {
  final UserDTO user;
  final List<HotItemsDTO> hotItems = [
    new HotItemsDTO(title: "Trung tâm nổi bật", route: "/school", list: [
      new ItemDTO(
          title: "Trung tâm A",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/school"),
      new ItemDTO(
          title: "Trung tâm B có tên siêu dài cần cắt bớt đi cho đẹp",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/school"),
      new ItemDTO(
          title: "Trung tâm C",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/school"),
    ]),
    new HotItemsDTO(title: "Chuyên gia nổi bật", route: "/teacher", list: [
      new ItemDTO(
          title: "Giảng viên A có tên siêu dài cần phải cắt đi",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/teacher"),
      new ItemDTO(
          title: "Chuyên gia B",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/teacher"),
      new ItemDTO(
          title: "Thầy giáo C",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/teacher"),
    ]),
  ];

  HomeBody({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        new HomeAppBar(user: user),
        new FeatureList(),
        new HomeBanner(),
        new HotItems(hotItems: hotItems,),
        new WeekCourseHeader(),
        new WeekCourses(),
      ],
    );
  }
}
