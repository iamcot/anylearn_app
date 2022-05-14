import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../customs/custom_carousel.dart';
import '../dto/article_dto.dart';
import '../dto/const.dart';
import 'youtube_image.dart';

class HomeArticleEvent extends StatelessWidget {
  final List<ArticleDTO> hotItems;
  final String title;

  HomeArticleEvent({required this.hotItems, required this.title});
  late double width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    width = this.hotItems.length == 1 ? (width - 30) : (width * 2 / 3 - 10);
    return SliverToBoxAdapter(
      child: hotItems.length == 0
          ? Container()
          : Container(
              margin: EdgeInsets.only(bottom: 20, top: 15),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  padding: EdgeInsets.only(left: 15, bottom: 15),
                  child: Text(
                    this.title.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                CustomCarousel(
                  items: hotItems,
                  builderFunction: _itemSlider,
                  height: width * 3 / 4,
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
        Navigator.of(context).pushNamed("/article", arguments: item.id);
      },
      child: Container(
        alignment: Alignment.topLeft,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: _articleImg(item),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  item.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

  Widget _articleImg(ArticleDTO articleDTO) {
    if (articleDTO.type == MyConst.ASK_TYPE_VIDEO) {
      return YoutubeImage(
        link: articleDTO.video,
        fit: BoxFit.cover,
      );
    }
    return articleDTO.image == null
        ? Image.asset(
            "assets/images/logo_app.jpg",
            fit: BoxFit.contain,
          )
        : CachedNetworkImage(
            imageUrl: articleDTO.image,
            fit: BoxFit.cover,
          );
  }
}
