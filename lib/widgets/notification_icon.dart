import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/main.dart';
import 'package:flutter/material.dart';
// import 'package:overlay_support/overlay_support.dart';

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
                // showOverlayNotification((context) {
                //   return SlideDismissible(
                //     enable: true,
                //     key: ValueKey(widget.key),
                //     child: Material(
                //       color: Colors.transparent,
                //       child: SafeArea(
                //           bottom: false,
                //           top: true,
                //           child: Container(
                //             margin: EdgeInsets.all(8),
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.all(Radius.circular(10)),
                //                 color: Colors.white,
                //                 border: Border.all(
                //                   color: Colors.grey,
                //                 )),
                //             child: ListTile(
                //               title: Text("hello"),
                //               trailing: Builder(builder: (context) {
                //                 return IconButton(
                //                     onPressed: () {
                //                       OverlaySupportEntry.of(context).dismiss();
                //                     },
                //                     icon: Icon(Icons.close));
                //               }),
                //             ),
                //           )),
                //     ),
                //   );
                // }, duration: Duration.zero);

                Navigator.of(context).pushNamed("/notification");
              })
          : null,
    );
  }
}
