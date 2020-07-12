import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../customs/custom_cached_image.dart';

class HomeBanner extends StatelessWidget {
  final List<String> imgList;

  const HomeBanner({Key key, this.imgList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        child: CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true,
            height: 150.0,
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
