import 'package:anylearn/screens/home/appbar.dart';
import 'package:anylearn/screens/home/banner.dart';
import 'package:anylearn/screens/home/features.dart';
import 'package:anylearn/screens/home/hot_items.dart';
import 'package:anylearn/screens/home/week_courses.dart';
import 'package:anylearn/screens/home/week_courses_header.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        new HomeAppBar(),
        new FeatureList(),
        new HomeBanner(),
        new HotItems(),
        new WeekCourseHeader(),
        new WeekCourses(),
      ],
    );
  }
}
