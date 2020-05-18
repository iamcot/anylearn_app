import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeBanner extends StatelessWidget {
  final List<String> imgList = [
    "assets/banners/banner-1.jpg",
    "assets/banners/banner-2.jpg",
    "assets/banners/banner-3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        child: CarouselSlider(
          options: CarouselOptions(enlargeCenterPage: true, height: 150.0),
          items: _imageSliders(),
        ),
      ),
    );
  }

  List<Widget> _imageSliders() {
    return this
        .imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  child: Image.asset(item, fit: BoxFit.cover),
                ),
              ),
            ))
        .toList();
  }
}
