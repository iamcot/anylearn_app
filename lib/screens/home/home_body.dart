import 'package:flutter/material.dart';

import '../../dto/home_dto.dart';
import '../../dto/user_dto.dart';
import 'appbar.dart';
import 'banner.dart';
import 'features.dart';
import 'hot_items.dart';
import 'week_courses.dart';
import 'week_courses_header.dart';

class HomeBody extends StatelessWidget {
  final UserDTO user;
  final HomeDTO homeData;

  HomeBody({Key key, this.user, this.homeData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        new HomeAppBar(user: user),
        new FeatureList(features: homeData.featuresIcons),
        new HomeBanner(
          imgList: homeData.banners,
        ),
        new HotItems(
          hotItems: homeData.hotItems,
        ),
        new WeekCourseHeader(),
        new WeekCourses(
          monthCourses: homeData.monthCourses,
        ),
      ],
    );
  }
}
