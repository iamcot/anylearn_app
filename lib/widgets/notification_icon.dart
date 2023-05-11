import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import '../main.dart';
// import 'package:overlay_support/overlay_support.dart';

class NotificationIcon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationIcon();
}

class _NotificationIcon extends State<NotificationIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: user.token != ""
          ? badges.Badge(
              position: badges.BadgePosition.topEnd(top: 5, end: 5),
              badgeContent: Text("!"),
              showBadge: newNotification,
              child: IconButton(
                color: Colors.grey[500],
                padding: EdgeInsets.all(0.0),
                icon: Icon(
                  Icons.notifications,
                  size: 24.0,
                ),
                onPressed: () {
                  setState(() {
                    newNotification = false;
                  });
                  Navigator.of(context).pushNamed("/notification");
                },
              ),
            )
          : null,
    );
  }
}
