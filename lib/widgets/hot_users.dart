import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../customs/custom_cached_image.dart';
import '../customs/custom_carousel.dart';
import '../dto/hot_users_dto.dart';

class HotUsers extends StatelessWidget {
  final List<HotUsersDTO> hotItems;

  HotUsers({required this.hotItems});
  late double width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    width = width * 2 / 3 - 10;
    return SliverToBoxAdapter(
      child: Container(child: Column(children: _buildList(context))),
    );
  }

  List<Widget> _buildList(BuildContext context) {
    return hotItems
        .map(
          (hotList) => Container(
            padding: EdgeInsets.only(bottom: 20.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
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
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(hotList.route);
                          },
                          child: Text(
                            "TẤT CẢ",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ).tr(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              CustomCarousel(
                items: hotList.list,
                builderFunction: _itemSlider,
                height: width * 3 / 4,
                width: width,
              ),
            ]),
          ),
        )
        .toList();
  }

  Widget _itemSlider(BuildContext context, dynamic item, double cardHeight) {
    // double width = MediaQuery.of(context).size.width;
    // width = width * 2 / 3 - 10;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("/items/" + item.role, arguments: item.id);
      },
      child: Card(
        elevation: 0,
        child: Container(
          alignment: Alignment.topLeft,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  // height: cardHeight * 3 / 4,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: item.image != null && item.image.isNotEmpty
                        ? CustomCachedImage(
                            url: item.banner ?? item.image,
                            fit: item.banner != null ? BoxFit.cover : BoxFit.fitHeight,
                          )
                        : Icon(Icons.broken_image),
                  ),
                ),
              ),
              Container(
                height: 38,
                padding: EdgeInsets.all(8),
                child: Text(
                  item.name ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
