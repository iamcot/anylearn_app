import 'dart:math' as math;

import 'package:anylearn/customs/custom_cached_image.dart';
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
    final width = MediaQuery.of(context).size.width;
    final imgH = (width - 40) / 3;
    final imgW = (width - 40) / 3;
    return CustomScrollView(
      slivers: <Widget>[
        SliverBanner(banner: this.schoolsData.banner),
        SchoolFilter(),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final int itemIndex = index ~/ 2;
              if (index.isEven) {
                return Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed("/items/school", arguments: schoolsData.list.data[itemIndex].id);
                    },
                    child: Stack(children: [
                      Container(
                          margin: EdgeInsets.only(top: imgH / 4, left: 10),
                          child: ConstrainedBox(
                            constraints: new BoxConstraints(
                              minHeight: imgH * 3 / 4 + 15,
                            ),
                            child: Card(
                              elevation: 0.5,
                              child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(left: imgW, top: 5, right: 10, bottom: 5),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text(
                                      schoolsData.list.data[itemIndex].name,
                                      style: TextStyle(fontWeight: FontWeight.w500),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    RatingBox(
                                      score: schoolsData.list.data[itemIndex].rating,
                                      alignment: "start",
                                    ),
                                    schoolsData.list.data[itemIndex].introduce != null
                                        ? Text(
                                            schoolsData.list.data[itemIndex].introduce,
                                            maxLines: 2,
                                            style: TextStyle(color: Colors.grey),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : Text(""),
                                  ])),
                            ),
                          )),
                      Container(
                        width: imgW,
                        height: imgH,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: schoolsData.list.data[itemIndex].image != null &&
                                schoolsData.list.data[itemIndex].image.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: schoolsData.list.data[itemIndex].image != null
                                    ? CustomCachedImage(url: schoolsData.list.data[itemIndex].image)
                                    : Icon(Icons.broken_image),
                              )
                            : SizedBox(
                                height: 60,
                                child: Icon(
                                  Icons.school,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                              ),
                      ),
                    ]),
                  ),
                );
              }
              return Divider(
                height: 0,
                color: Colors.transparent,
              );
            },
            childCount: math.max(0, schoolsData.list.data.length * 2 - 1),
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
