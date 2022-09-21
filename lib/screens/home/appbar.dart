import 'package:anylearn/widgets/locale_icon.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../widgets/account_icon.dart';
import '../../widgets/foundation_icon.dart';
import '../../widgets/notification_icon.dart';
import '../webview.dart';
import 'home_top_icons.dart';

class HomeAppBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeAppBar();
}

class _HomeAppBar extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    double statusHeight =
        MediaQuery.of(context).padding.top; //iOS = 44 & Android = 22
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
        // AddCourseIcon(),
        // SearchIcon(),
        user.token == "" || !user.enableIosTrans
            ? Text("")
            : Container(
                child: Badge(
                  position: BadgePosition.topEnd(top: 5, end: 5),
                  showBadge: user.cartcount > 0,
                  badgeContent: Text(
                    user.cartcount.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  child: IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WebviewScreen(
                                  url: config.webUrl + "cart",
                                  token: user.token,
                                )));
                      }),
                ),
              ),
        LocaleIcon(),
        FoundationIcon(),
        NotificationIcon(),
        AccountIcon(
          user: user,
        ),
      ],
      flexibleSpace: LayoutBuilder(
        builder: (context, bc) {
          return FlexibleSpaceBar(
            centerTitle: false,
            background: new ClipRect(
              child: new Container(
                child: Container(
                    margin: EdgeInsets.fromLTRB(30.0, 90.0, 30.0, 5.0),
                    child: HomeTopIcons(
                      user: user,
                    )),
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
