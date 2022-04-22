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

  const BaseAppBar({required this.title, this.screen = "", this.hasBack = true, required this.user});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: hasBack,
      titleSpacing: 10.0,
      foregroundColor: Colors.grey,
      actions: <Widget>[
        user.id == 0 || !user.enableIosTrans
            ? Text("")
            : IconButton(
                color: Colors.grey[500],
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WebviewScreen(
                            url: config.webUrl + "cart",
                            token: user.token,
                          )));
                }),
        (screen != "notification" && screen != "home")
            ? SearchIcon(
                screen: screen,
              )
            : Text(""),
        NotificationIcon(user: user,),
        screen != "account" && screen != "notification"
            ? new AccountIcon(
                user: user,
              )
            : Text(""),
      ],
      centerTitle: false,
      title: title != ""
          ? Text(
              title,
              style: TextStyle(fontSize: 14.0),
            )
          : Image.asset(
              "assets/images/logo-full.png",
              fit: BoxFit.cover,
              height: 32.0,
            ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(56.0);
}
