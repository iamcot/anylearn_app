import 'package:anylearn/main.dart';
import 'package:anylearn/screens/webview.dart';

import '../dto/user_dto.dart';
import '../widgets/account_icon.dart';
import '../widgets/notification_icon.dart';
import '../widgets/search_icon.dart';
import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String screen;
  final bool hasBack;
  final UserDTO user;

  const BaseAppBar({this.title, this.screen, this.hasBack, this.user});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: hasBack ?? true,
      titleSpacing: 0.0,
      actions: <Widget>[
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
        screen != "notification"
            ? SearchIcon(
                screen: screen,
              )
            : Text(""),
        screen != "account" && screen != "notification" ? NotificationIcon() : Container(child: null),
        screen != "account" && screen != "notification"
            ? new AccountIcon(
                user: user ?? null,
              )
            : Text(""),
      ],
      centerTitle: false,
      title: Text(
        title,
        style: TextStyle(fontSize: 14.0),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(56.0);
}
