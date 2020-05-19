import 'package:anylearn/screens/home/wallet_card.dart';
import 'package:anylearn/widgets/account_icon.dart';
import 'package:anylearn/widgets/notification_icon.dart';
import 'package:anylearn/widgets/search_icon.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double statusHeight = MediaQuery.of(context).padding.top;//iOS = 44 & Android = 22
    return SliverAppBar(
      expandedHeight: 185 - (statusHeight - 24),
      title: Image.asset(
        "assets/images/logo.png",
        height: 24.0,
      ),
      centerTitle: false,
      floating: false,
      pinned: true,
      actions: <Widget>[
        SearchIcon(),
        NotificationIcon(),
        AccountIcon(),
      ],
      flexibleSpace: LayoutBuilder(
        builder: (context, bc) {
          return FlexibleSpaceBar(
            centerTitle: false,
            background: new ClipRect(
              child: new Container(
                child: Container(margin: EdgeInsets.fromLTRB(30.0, 90.0, 30.0, 5.0), child: WalletCard()),
                decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/bg.png",
                      ),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
