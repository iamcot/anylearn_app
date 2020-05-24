import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../dto/users_dto.dart';
import '../../widgets/rating.dart';
import '../../widgets/sliver_banner.dart';
import 'school_filter.dart';

class SchoolBody extends StatelessWidget {
  final UsersDTO schoolsData;

  const SchoolBody({Key key, this.schoolsData}) : super(key: key);
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
