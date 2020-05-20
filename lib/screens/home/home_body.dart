import 'package:anylearn/dto/hot_items_dto.dart';
import 'package:anylearn/dto/item_dto.dart';
import 'package:anylearn/screens/home/appbar.dart';
import 'package:anylearn/screens/home/banner.dart';
import 'package:anylearn/screens/home/features.dart';
import 'package:anylearn/screens/home/hot_items.dart';
import 'package:anylearn/screens/home/week_courses.dart';
import 'package:anylearn/screens/home/week_courses_header.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        new HomeAppBar(),
        new FeatureList(),
        new HomeBanner(),
        new HotItems(hotItems: hotItems,),
        new WeekCourseHeader(),
        new WeekCourses(),
      ],
    );
  }
}
