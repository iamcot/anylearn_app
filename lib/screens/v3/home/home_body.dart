import 'package:anylearn/screens/v3/home/home_articles.dart';
import 'package:anylearn/screens/v3/home/home_ask.dart';
import 'package:anylearn/screens/v3/home/home_banner.dart';
import 'package:anylearn/screens/v3/home/home_classes.dart';
import 'package:anylearn/screens/v3/home/home_features.dart';
import 'package:anylearn/screens/v3/home/home_vouchers.dart';
import 'package:anylearn/widgets/items_list_2.dart';
import 'package:anylearn/widgets/items_list_3.dart';

import '../../../blocs/home/home_bloc.dart';
import '../../../dto/v3/home_dto.dart';
import 'home_pointbox.dart';
import 'package:flutter/material.dart';

import 'home_subtype.dart';

bool canShowPopup = true;

class V3HomeBody extends StatefulWidget {
  const V3HomeBody({Key? key, required this.homeData, required this.homeBloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _V3HomeBody();
  final HomeV3DTO homeData;
  final HomeBloc homeBloc;
}

class _V3HomeBody extends State<V3HomeBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HomeSubtype(),
        HomePointBox(
          anyPoint: widget.homeData.pointBox.anypoint,
          ratingItem: widget.homeData.pointBox.ratingClass,
          goingItem: widget.homeData.pointBox.goingClass,
        ),
        ItemsList3(hotItems: widget.homeData.j4u),
        ItemsList2(hotItems: widget.homeData.repurchaseds),
        HomeBanner(banners: widget.homeData.banners, promotions: widget.homeData.promotions),
        ItemsList3(hotItems: widget.homeData.recommendations),
        HomeVoucher(vouchers: widget.homeData.vouchers),
        HomeFeatures(),
        HomeClasses(blocks: widget.homeData.classes),
        HomeAsk(ask: widget.homeData.asks),
        HomeArticles(articles: widget.homeData.articles)
      ],
    );
  }
}
