import 'package:anylearn/customs/custom_cached_image.dart';
import 'package:anylearn/dto/item_dto.dart';
import 'package:anylearn/widgets/calendar_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:intl/intl.dart';

class WeekCourses extends StatelessWidget {
  final List<ItemDTO> monthCourses;
  final DateFormat _formatDate = DateFormat("dd/MM");

  WeekCourses({key, required this.monthCourses}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final int itemIndex = index ~/ 2;
          if (index.isEven) {
            final width = MediaQuery.of(context).size.width;
            final imgH = (width - 40) / 3;
            final imgW = (width - 40) / 3;
            return Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("/pdp", arguments: monthCourses[itemIndex].id);
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
                                  monthCourses[itemIndex].title,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                monthCourses[itemIndex].shortContent != null
                                    ? Text(
                                        monthCourses[itemIndex].shortContent,
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
                    child: monthCourses[itemIndex].image != null && monthCourses[itemIndex].image.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: monthCourses[itemIndex].image != null
                                ? CustomCachedImage(url: monthCourses[itemIndex].image)
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

            // return ListTile(
            //   isThreeLine: true,
            //   // dense: true,
            //   leading: monthCourses[itemIndex].image != null
            //       ? Container(
            //         padding: EdgeInsets.all(0),
            //           // width: 120,
            //           height: 120,
            //           child: CachedNetworkImage(
            //             imageUrl: monthCourses[itemIndex].image,
            //             fit: BoxFit.contain,
            //           ),
            //         )
            //       : CalendarBox(
            //           fontSize: 12.0, text: _formatDate.format(DateTime.parse(monthCourses[itemIndex].dateStart))),
            //   onTap: () {
            //     Navigator.of(context).pushNamed("/pdp", arguments: monthCourses[itemIndex].id);
            //   },
            //   title: Text(
            //     monthCourses[itemIndex].title,
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //     ),
            //     maxLines: 2,
            //     overflow: TextOverflow.ellipsis,
            //   ),
            //   // trailing: Icon(Icons.chevron_right),
            //   subtitle: monthCourses[itemIndex].shortContent != null
            //       ? Text(monthCourses[itemIndex].shortContent, maxLines: 2, overflow: TextOverflow.ellipsis)
            //       : Text(""),
            // );
          }
          return Divider(
            height: 0,
            color: Colors.grey[200],
          );
        },
        childCount: math.max(0, monthCourses.length * 2 - 1),
        semanticIndexCallback: (Widget widget, int localIndex) {
          if (localIndex.isEven) {
            return localIndex ~/ 2;
          }
          return null;
        },
      ),
    );
  }
}
