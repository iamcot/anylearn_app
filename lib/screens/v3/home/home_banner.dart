import 'dart:ui';

import 'package:anylearn/customs/custom_cached_image.dart';
import 'package:anylearn/customs/custom_carousel.dart';
import 'package:flutter/material.dart';

import '../../../dto/article_dto.dart';
import '../../../dto/v3/home_dto.dart';

class HomeBanner extends StatelessWidget {
  final List<HomeBannerDTO> banners;
  final List<ArticleDTO> promotions;
  late double width;

  HomeBanner({Key? key, required this.banners, required this.promotions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      height: width,
      child: Stack(
        children: [
          CustomCarousel(
            items: banners,
            builderFunction: _bannerSlider,
            height: width,
            width: width,
            dividerIndent: 0,
          ),
          Container(
            margin: EdgeInsets.only(top: width * 2 / 3),
            height: width / 3,
            child: CustomCarousel(
              items: promotions,
              builderFunction: _promotionSlider,
              height: width / 3,
              width: width,
            ),
          )
        ],
      ),
    );
  }

  Widget _bannerSlider(BuildContext context, dynamic item, double cardHeight) {
    final boxWidth = width;
    final height = width * 2 / 3;
    return Container(
      width: boxWidth,
      height: height,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: width,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.dstATop),
                image: NetworkImage(item.file),
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 20,
                sigmaY: 20,
              ),
              child: new Container(
                decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: width * 2 / 3,
            child: CustomCachedImage(
              url: item.file,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  final promoColors = [Colors.red, Colors.orange, Colors.blue, Colors.purple, Colors.green];
  Widget _promotionSlider(BuildContext context, dynamic item, double cardHeight) {
    return Container(
      width: width / 3,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: (promoColors.toList()..shuffle()).first,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            item.shortContent,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
