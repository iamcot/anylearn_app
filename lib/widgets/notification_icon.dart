import 'package:anylearn/dto/user_dto.dart';
import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  final UserDTO user;

  const NotificationIcon({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: user!= null ? IconButton(
          padding: EdgeInsets.all(0.0),
          icon: Icon(
            Icons.notifications,
            size: 24.0,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed("/notification");
          }) : null,
    );
  }
}
