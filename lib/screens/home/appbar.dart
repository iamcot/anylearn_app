import 'package:anylearn/main.dart';
import 'package:anylearn/screens/webview.dart';
import 'package:flutter/material.dart';

import '../../dto/user_dto.dart';
import '../../widgets/account_icon.dart';
import '../../widgets/foundation_icon.dart';
import '../../widgets/notification_icon.dart';
import 'home_top_icons.dart';

class HomeAppBar extends StatelessWidget {
  final UserDTO user;

  const HomeAppBar({Key key, this.user}) : super(key: key);
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
        user == null
            ? Text("")
            : IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WebviewScreen(
                            url: config.webUrl + "cart",
                            token: user.token,
                          )));
                }),
        FoundationIcon(),
        NotificationIcon(
          user: user,
        ),
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
