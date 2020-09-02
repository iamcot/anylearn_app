import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../customs/custom_cached_image.dart';

class HomeBanner extends StatelessWidget {
  final List<String> imgList;
  final double ratio;

  const HomeBanner({Key key, this.imgList, this.ratio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 80;
    final height = width * ratio;
    return SliverToBoxAdapter(
      child: Container(
        child: CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true,
            height: height,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
          ),
          items: _imageSliders(context),
        ),
      ),
    );
  }

  List<Widget> _imageSliders(BuildContext context) {
    return this
        .imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  child: CustomCachedImage(url: item),
                ),
              ),
            ))
        .toList();
  }
}
