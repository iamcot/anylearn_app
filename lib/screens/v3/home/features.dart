import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../customs/custom_carousel.dart';

class HomeFeatures extends StatelessWidget {
  late double width;

  final List<Map<String, dynamic>> features = [
    {"title": "Bản đồ", "icon": Icons.map_outlined, "route": "/map"},
    {"title": "anyLEARN Foundation", "icon": MdiIcons.piggyBankOutline, "route": "/foundation"},
    {"title": "Bạn bè", "icon": MdiIcons.accountGroup, "route": "/account/friends"},
    {"title": "Lịch học", "icon": MdiIcons.calendarClock, "route": "/account/calendar"},
  ];

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width / 4;
    return Container(
      margin: EdgeInsets.only(left:10, bottom: 10, top: 10),
      child: CustomCarousel(
        items: features,
        builderFunction: _itemSlider,
        height: width,
        width: width,
      ),
    );
  }

  Widget _itemSlider(BuildContext context, dynamic item, double cardHeight) {
    final boxWidth = width;
    return Container(
      width: boxWidth,
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.pink[50],
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(item["route"]);
        },
        child: Stack(
          children: [
            Text(
              item["title"],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold, color: Colors.green[800]),
            ),
            Container(
              alignment: Alignment.bottomRight,
              width: boxWidth,
              height: boxWidth,
              // decoration: BoxDecoration(
              //   backgroundBlendMode: 
              // ),
              child: Icon(
                item["icon"],
                color: Colors.blue.withOpacity(0.3),
                size: boxWidth / 1.5,
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
