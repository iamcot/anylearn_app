import 'package:anylearn/customs/custom_cached_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../customs/custom_carousel.dart';
import '../dto/hot_items_dto.dart';

class HotItems extends StatelessWidget {
  final List<HotItemsDTO> hotItems;

  const HotItems({required this.hotItems});
  @override
  Widget build(BuildContext context) {
    return Container(child: Column(children: _buildList(context)));
  }

  List<Widget> _buildList(BuildContext context) {
    return hotItems
        .map(
          (hotList) => Container(
            padding: EdgeInsets.only(bottom: 20.0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 15.0,
                  color: (Colors.grey[100])!,
                ),
              ),
            ),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        hotList.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    hotList.route == ""
                        ? SizedBox(
                            height: 0,
                          )
                        : Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(hotList.route);
                                },
                                child: Text(
                                  "Tất cả".tr(),
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              ),
              CustomCarousel(items: hotList.list, builderFunction: _itemSlider, height: 170.0),
            ]),
          ),
        )
        .toList();
  }

  Widget _itemSlider(BuildContext context, dynamic item, double cardHeight) {
    double width = MediaQuery.of(context).size.width;
    width = width - width / 3;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("/pdp", arguments: item.id);
      },
      child: Card(
        child: Container(
          alignment: Alignment.topLeft,
          width: width,
          child: Column(
            children: [
              Container(
                height: cardHeight * 2 / 3,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0), topRight: Radius.circular(7.0)),
                  child: item.image != null && item.image.isNotEmpty
                      ? CustomCachedImage(url: item.image)
                      : Icon(Icons.broken_image),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(15.0),
                child: Text(
                  item.title ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
