import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/main.dart';
import 'package:flutter/material.dart';

class NotificationIcon extends StatefulWidget {
  final UserDTO user;

  const NotificationIcon({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NotificationIcon();
}

class _NotificationIcon extends State<NotificationIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.user != null
          ? IconButton(
              padding: EdgeInsets.all(0.0),
              icon: Stack(children: [
                Icon(
                  Icons.notifications,
                  size: 24.0,
                ),
                newNotification
                    ? Container(
                        padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                        margin: EdgeInsets.only(left: 3),
                        decoration:
                            BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Text(
                          "!",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                        ))
                    : SizedBox(height: 0),
              ]),
              onPressed: () {
                setState(() {
                  newNotification = false;
                });
                Navigator.of(context).pushNamed("/notification");
              })
          : null,
    );
  }
}
