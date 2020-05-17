import 'package:anylearn/widgets/account_icon.dart';
import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String screen;

  const BaseAppBar({this.title, this.screen});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: screen == "account" ? true : false,
      actions: <Widget>[screen != "account" ? new AccountIcon() : Text("")],
      title: Text(
        title,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(56.0);
}
