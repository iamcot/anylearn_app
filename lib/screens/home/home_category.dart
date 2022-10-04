import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';

import '../../customs/custom_cached_image.dart';
import '../../customs/custom_carousel.dart';
import '../../dto/home_dto.dart';

class HomeCategory extends StatelessWidget {
  final List<CategoryDTO> categories;

  HomeCategory({key, required this.categories}) : super(key: key);
  late double width;

  @override
  Widget build(BuildContext context) {
        Text('title');

    width = MediaQuery.of(context).size.width;
    width = width * 2 / 3 - 10;
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        color: Colors.grey[200],
        child: Column(children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "CÁC LĨNH VỰC HỌC TẬP".tr(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          CustomCarousel(
            items: categories,
            builderFunction: _itemSlider,
            height: width / 3 * 2,
            width: width,
          ),
        ]),
      ),
    );
  }

  Widget _itemSlider(BuildContext context, dynamic item, double cardHeight) {
    final boxWidth = width;
    final imageWH = (boxWidth - 40) / 2;
    return Container(
      width: boxWidth,
      child: Card(
          child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green[600]),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: List<Widget>.from(item.items.map((e) => InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("/pdp", arguments: e.id);
                      },
                      child: Container(
                        width: imageWH,
                        height: imageWH,
                        margin: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: (Colors.grey[200])!), borderRadius: BorderRadius.circular(5)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          // borderRadius: BorderRadius.circular(8.0),
                          child: e.image != null ? CustomCachedImage(url: e.image) : Icon(Icons.broken_image),
                        ),
                      ),
                    ))).toList(),
              ),
            )
          ],
        ),
      )),
    );
  }
}
