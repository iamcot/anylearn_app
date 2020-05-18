import 'package:anylearn/widgets/account_icon.dart';
import 'package:anylearn/widgets/notification_icon.dart';
import 'package:anylearn/widgets/search_icon.dart';
import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String screen;
  final bool hasBack;

  const BaseAppBar({this.title, this.screen, this.hasBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: hasBack ?? true,
      titleSpacing: 0.0,
      actions: <Widget>[
        screen != "notification" ? SearchIcon() : Text(""),
        screen != "account" && screen != "notification" ? NotificationIcon() : Text(""),
        screen != "account" && screen != "notification" ? new AccountIcon() : Text(""),
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
