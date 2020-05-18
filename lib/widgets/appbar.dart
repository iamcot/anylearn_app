import 'package:anylearn/widgets/account_icon.dart';
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
      automaticallyImplyLeading: hasBack ?? false,
      actions: <Widget>[
        SearchIcon(),
        screen != "account" ? new AccountIcon() : Text("")],
      centerTitle: false,
      title: Text(
        title,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(56.0);
}
