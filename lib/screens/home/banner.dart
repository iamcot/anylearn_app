import 'dart:collection';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../dto/home_dto.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../customs/custom_cached_image.dart';

class HomeBanner extends StatefulWidget {
  final List<HomeBannerDTO> banners;
  final double ratio;

  const HomeBanner({key, required this.banners, required this.ratio}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeBanner();
}

class _HomeBanner extends State<HomeBanner> {
  Map<String, YoutubePlayerController> _controllers = new HashMap();
  @override
  void initState() {
    widget.banners.forEach((banner) {
      if (banner.route == "video") {
        _controllers.putIfAbsent(
            banner.arg,
            () => YoutubePlayerController(
                initialVideoId: YoutubePlayer.convertUrlToId(banner.arg)!, flags: YoutubePlayerFlags()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 80;
    final height = width * widget.ratio;
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top:15.0),
        child: CarouselSlider(
          options: CarouselOptions(
            initialPage: 0,
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
        .widget
        .banners
        .map((banner) => Container(
              child: Container(
                margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  child: _buildBanner(context, banner),
                ),
              ),
            ))
        .toList();
  }

  Widget _buildBanner(BuildContext context, HomeBannerDTO banner) {
    if (banner.route == "video") {
      return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controllers[banner.arg]!,
        ),
        builder: (context, player) => Container(
          child: player,
        ),
      );
    } else {
      return InkWell(
        child: CustomCachedImage(url: banner.file),
        onTap: () {
          if (banner.route.isNotEmpty) {
            Navigator.of(context).pushNamed(banner.route, arguments: banner.arg);
            return;
          }
        },
      );
    }
  }
}
