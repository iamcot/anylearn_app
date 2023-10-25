import 'dart:io';

import 'package:anylearn/main.dart';
import 'package:flutter/material.dart';

import '../../../customs/custom_cached_image.dart';
import '../../../customs/custom_carousel.dart';
import '../../../dto/user_dto.dart';
import '../subtype/screen.dart';

class HomeSubtype extends StatelessWidget {
  late double width;
  final UserDTO user;
  final enableIosTrans;

  final List<Map<String, dynamic>> subtypes = [
    {"type": "offline", "title": "Hệ K12", "image": "", "icon": Icons.school_outlined, "checkIos": false},
    {"type": "preschool", "title": "Mầm non", "image": "", "icon": Icons.child_care_outlined, "checkIos": false},
    {"type": "extra", "title": "Ngoại khóa", "image": "", "icon": Icons.sports_baseball_outlined, "checkIos": false},
    {"type": "online", "title": "Học Online", "image": "", "icon": Icons.broadcast_on_home_rounded, "checkIos": true},
    {"type": "digital", "title": "Ứng dụng", "image": "", "icon": Icons.code, "checkIos": true},
    // {"type": "video", "title": "Học Video", "image": "", "icon": Icons.ondemand_video_outlined, "checkIos": true},
  ];

  HomeSubtype({Key? key, required this.user, this.enableIosTrans = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    width = width / 5;
    return Container(
      margin: EdgeInsets.only(bottom: 5, top: 15),
      child: CustomCarousel(
        items: subtypes,
        builderFunction: _itemSlider,
        height: width,
        width: width,
      ),
    );
  }

  Widget _itemSlider(BuildContext context, dynamic item, double cardHeight) {
    final boxWidth = width;
    final imageWH = width - 25.0;
    if (item["checkIos"] && !enableIosTrans && Platform.isIOS) {
      return Container();
    }
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => SubtypeScreen(subtype: item))
      ),
      child: Container(
        width: boxWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              width: imageWH,
              height: imageWH,
              child: CircleAvatar(
                backgroundColor: Colors.blue[50],
                child: item["image"] != ""
                    ? CustomCachedImage(url: item["image"])
                    : Icon(
                        item["icon"],
                        color: Colors.blue,
                        size: imageWH / 1.5,
                      ),
              ),
            ),
            Text(
              item["title"],
              style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
