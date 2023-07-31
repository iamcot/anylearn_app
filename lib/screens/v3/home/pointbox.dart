import 'package:flutter/material.dart';
import '../../../customs/custom_carousel.dart';

class HomePointBox extends StatelessWidget {
  late double width;
  final String anyPoint;
  final String ratingItem;
  final String goingItem;

  late List<Map<String, dynamic>> boxes;

  HomePointBox({Key? key, required this.anyPoint, required this.ratingItem, required this.goingItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    boxes = [
      {"title": "anyPoint", "value": anyPoint, "icon": Icons.account_balance_wallet_outlined, "url": "", "color": Colors.pink},
      {"title": "Lớp đang học", "value": goingItem, "icon": Icons.calendar_month_outlined, "url": "", "color": Colors.green},
      {"title": "Đánh giá", "value": ratingItem, "icon": Icons.star_border_outlined, "url" : "", "color": Colors.orange},
    ];
    final screenW = MediaQuery.of(context).size.width;
    width = screenW * 2 / 5;
    return Container(
      margin: EdgeInsets.only(left: 10, bottom: 10, top: 20),
      child: CustomCarousel(
        items: boxes,
        builderFunction: _itemSlider,
        height: 60,
        width: width,
      ),
    );
  }

  Widget _itemSlider(BuildContext context, dynamic item, double cardHeight) {
    // final screenW = MediaQuery.of(context).size.width;
    final boxWidth = item["title"] == "anyPoint"  ? width * 0.9 : width + 50;
    return Container(
        width: boxWidth,
        padding: EdgeInsets.only(top: 5, left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[100],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["title"],
                  style: TextStyle(fontSize: 16, height: 1.2, fontWeight: FontWeight.w300),
                ),
                Text(
                  item["value"].toString(),
                  style: TextStyle(fontSize: 18, height: 1.5, fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis),
                ),
              ],
            )),
            Icon(item["icon"], color: item["color"], size: 30,)
          ],
        ));
  }
}
