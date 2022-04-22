import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../../dto/user_dto.dart';
import '../../main.dart';
import '../../widgets/account_icon.dart';
import '../../widgets/foundation_icon.dart';
import '../../widgets/notification_icon.dart';
import '../webview.dart';
import 'home_top_icons.dart';

class HomeAppBar extends StatefulWidget {
  final UserDTO user;

  const HomeAppBar({key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeAppBar();
}

class _HomeAppBar extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    double statusHeight = MediaQuery.of(context).padding.top; //iOS = 44 & Android = 22
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
        widget.user == null || !widget.user.enableIosTrans
            ? Text("")
            : Container(
                child: Badge(
                  position: BadgePosition.topEnd(top: 5, end: 5),
                  showBadge: widget.user.cartcount > 0,
                  badgeContent: Text(
                    widget.user.cartcount.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  child: IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WebviewScreen(
                                  url: config.webUrl + "cart",
                                  token: widget.user.token,
                                )));
                      }),
                ),
              ),
        FoundationIcon(),
        NotificationIcon(
          user: widget.user,
        ),
        AccountIcon(
          user: widget.user,
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
                      user: widget.user,
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
