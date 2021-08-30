import 'package:anylearn/dto/login_callback.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../dto/user_dto.dart';

class AccountIcon extends StatefulWidget {
  final UserDTO user;
  const AccountIcon({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AccountIcon();
}

class _AccountIcon extends State<AccountIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10.0),
      child: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.of(context).pushNamed("/account");
            // if (widget.user != null) {
            //   Navigator.of(context).pushNamed("/profile", arguments: widget.user.id);
            // } else {
            //   Navigator.of(context).pushNamed("/login", arguments: LoginCallback(routeName: "/profile"));
            // }
          }),
    );
  }
}
