import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
          padding: EdgeInsets.all(0.0),
          icon: Icon(
            Icons.notifications,
            size: 24.0,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed("/notification");
          }),
    );
  }
}
