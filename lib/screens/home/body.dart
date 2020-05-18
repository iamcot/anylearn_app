
import 'package:anylearn/screens/home/appbar.dart';
import 'package:anylearn/screens/home/banner.dart';
import 'package:anylearn/screens/home/features.dart';
import 'package:anylearn/screens/home/hot_items.dart';
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
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ListTile(
                title: Text("Text"),
              );
            },
            childCount: 5,
          ),
        ),
      ],
    );
  }
}
