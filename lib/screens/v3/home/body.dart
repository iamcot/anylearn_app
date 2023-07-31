import 'package:anylearn/dto/user_dto.dart';

import 'articles.dart';
import 'ask.dart';
import 'banner.dart';
import 'classes.dart';
import 'features.dart';
import 'vouchers.dart';
import '../../../widgets/items_list_2.dart';
import '../../../widgets/items_list_3.dart';

import '../../../blocs/home/home_bloc.dart';
import '../../../dto/v3/home_dto.dart';
import 'pointbox.dart';
import 'package:flutter/material.dart';

import 'subtype.dart';

bool canShowPopup = true;

class V3HomeBody extends StatefulWidget {
  final UserDTO user;
  final HomeV3DTO homeData;
  final HomeBloc homeBloc;

  const V3HomeBody({Key? key, required this.user, required this.homeData, required this.homeBloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _V3HomeBody();
}

class _V3HomeBody extends State<V3HomeBody> {
  @override
  Widget build(BuildContext context) {
    return widget.user.token != ''
      ? ListView(
          children: [
            HomeSubtype(user: widget.user),
            HomePointBox(
              anyPoint: widget.homeData.pointBox.anypoint.toString(),
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
            //HomeAsk(ask: widget.homeData.asks),
            HomeArticles(articles: widget.homeData.articles)
          ]
        )
      : ListView(
          children: [
            HomeSubtype(user: widget.user),
            ItemsList3(hotItems: widget.homeData.recommendations),
            HomeBanner(banners: widget.homeData.banners, promotions: widget.homeData.promotions),
            HomeVoucher(vouchers: widget.homeData.vouchers),
            HomeFeatures(),
            HomeClasses(blocks: widget.homeData.classes),
            //HomeAsk(ask: widget.homeData.asks),
            HomeArticles(articles: widget.homeData.articles)
          ]
        );
  }
}
