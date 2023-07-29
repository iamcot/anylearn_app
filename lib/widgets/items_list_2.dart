import 'package:anylearn/customs/custom_cached_image.dart';
import 'package:anylearn/screens/v3/home/item_card.dart';
import 'package:flutter/material.dart';

import '../customs/custom_carousel.dart';
import '../dto/hot_items_dto.dart';

class ItemsList2 extends StatelessWidget {
  final HotItemsDTO hotItems;
  final screenSplit = 2;

  const ItemsList2({required this.hotItems});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.width / screenSplit + 90;
    return hotItems.list == null
        ? Container()
        : Container(
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        hotItems.title.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomCarousel(items: hotItems.list, builderFunction: _itemSlider, height: height),
            ]),
          );
  }

  Widget _itemSlider(BuildContext context, dynamic item, double cardHeight) {
    final width = MediaQuery.of(context).size.width / screenSplit;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("/pdp", arguments: item.id);
      },
      child: Container(
          alignment: Alignment.topLeft,
          width: width,
          height: cardHeight,
          child: ItemCard(
            width: width,
            item: item,
          )),
    );
  }
}
