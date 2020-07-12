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
          icon: widget.user == null || widget.user.image == null
              ? Icon(
                  Icons.account_circle,
                  size: 32.0,
                )
              : CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: CachedNetworkImageProvider(widget.user.image),
                  ),
                ),
          onPressed: () {
            // Navigator.of(context).pushNamed("/account");
            Navigator.of(context).pushNamed(widget.user != null ? "/account" : "/login");
          }),
    );
  }
}
