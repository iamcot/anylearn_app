import 'package:anylearn/dto/article_dto.dart';
import 'package:flutter/material.dart';

import '../customs/custom_cached_image.dart';
import '../customs/custom_carousel.dart';

class Promotions extends StatelessWidget {
  final List<ArticleDTO> hotItems;

  Promotions({Key key, this.hotItems}) : super(key: key);
  double width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    width = this.hotItems.length == 1 ? (width - 30) : (width * 2 / 3 - 10);
    final height = this.hotItems.length == 1 ? (width * 2 / 3) : (width * 3 / 4);
    return SliverToBoxAdapter(
      child: hotItems == null || hotItems.length == 0
          ? Container()
          : Container(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: EdgeInsets.only(left: 15, bottom: 15),
                child: Text(
                  "CÁC KHOÁ HỌC ƯU ĐÃI",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              CustomCarousel(
                items: hotItems,
                builderFunction: _itemSlider,
                height: height,
                width: width,
              ),
            ])),
    );
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
                    borderRadius: BorderRadius.circular(10),
                    child: item.image != null && item.image.isNotEmpty
                        ? CustomCachedImage(
                            url: item.image,
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.broken_image),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
