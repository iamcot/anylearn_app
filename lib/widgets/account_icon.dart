import 'package:flutter/material.dart';

import '../dto/user_dto.dart';

class AccountIcon extends StatefulWidget {
  final UserDTO user;
  const AccountIcon({required this.user});

  @override
  State<StatefulWidget> createState() => _AccountIcon();
}

class _AccountIcon extends State<AccountIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10.0),
      child: IconButton(
         color: Colors.grey[500],
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
