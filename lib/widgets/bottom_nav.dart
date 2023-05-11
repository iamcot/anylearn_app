import 'package:anylearn/dto/login_callback.dart';
import 'package:anylearn/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class BottomNav extends StatelessWidget {
  // static const HOME_INDEX = "/";
  // static const SCHOOL_INDEX = "/school";
  // static const TEACHER_INDEX = "/teacher";
  // static const PROFILE_INDEX = "/profile";
  // static const ASK_INDEX = "/ask";
  // static const ACCOUNT_INDEX = "/account";
  static const HOME_INDEX = 0;
  static const SOCIAL_INDEX = 1;
  static const MYCLASS_INDEX = 2;
  static const NOTI_INDEX = 3;
  static const ACCOUNT_INDEX = 4;

  static Map<int, String> _routes = {
    HOME_INDEX: "/",
    MYCLASS_INDEX: "/mycalendar",
    SOCIAL_INDEX: "/social",
    NOTI_INDEX: "/notification",
    ACCOUNT_INDEX: "/account",
  };

  final int index;
  final String callback;

  BottomNav(this.index, {this.callback = ""});

  @override
  Widget build(BuildContext context) {
    return
        // BottomAppBar(
        //   shape: CircularNotchedRectangle(),
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       Container(
        //         width: 60.0,
        //         child: Text(""),
        //       ),
        //       IconButton(
        //           onPressed: () {
        //             _navigate(context, SCHOOL_INDEX);
        //           },
        //           icon: Icon(
        //             Icons.school,
        //             color: route == SCHOOL_INDEX ? Colors.green[600] : Colors.grey[500],
        //           )),
        //       IconButton(
        //           onPressed: () {
        //             _navigate(context, TEACHER_INDEX);
        //           },
        //           icon: Icon(
        //             Icons.supervised_user_circle,
        //             color: route == TEACHER_INDEX ? Colors.green[600] : Colors.grey[500],
        //           )),
        //       IconButton(
        //           onPressed: () {
        //             if (user.token != "") {
        //               Navigator.of(context).canPop()
        //                   ? Navigator.of(context).popAndPushNamed("/profile", arguments: user.id)
        //                   : Navigator.of(context).pushNamed("/profile", arguments: user.id);
        //             } else {
        //               Navigator.of(context).pushNamed("/login", arguments: LoginCallback(routeName: "/profile"));
        //             }
        //           },
        //           icon: Icon(
        //             Icons.account_circle,
        //             color: route == PROFILE_INDEX ? Colors.green[600] : Colors.grey[500],
        //           )),

        //       FloatingActionButton.extended(
        //           onPressed: () {
        //             _navigate(context, ACCOUNT_INDEX);
        //           },
        //           icon: Icon(
        //             Icons.account_circle_outlined,
        //             color: route == ACCOUNT_INDEX ? Colors.green[600] : Colors.grey[500],
        //           ),
        //           label: Text("Tài khoản")),

        //     ],
        //   ),
        // );
        BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            selectedItemColor: Colors.green[800],
            unselectedItemColor: Colors.grey[500],
            unselectedIconTheme: IconThemeData(color: Colors.black45),
            showUnselectedLabels: true,
            iconSize: 28.0,
            selectedFontSize: 12.0,
            unselectedFontSize: 11.0,
            currentIndex: this.index,
            onTap: (i) => _navigate(context, index),
            items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/logo_app_trans.png",
              fit: BoxFit.contain,
              width: 34.0,
              height: 34.0,
            ),
            label: "Trang chủ",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_outlined),
            label: "Cộng đồng",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.all_inclusive_outlined),
            label: "Lớp học",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_rounded),
            label: "Thông báo",
          ),
          BottomNavigationBarItem(
            icon: user.image == ""
                ? Icon(
                    Icons.account_circle_outlined,
                  )
                : CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundImage: CachedNetworkImageProvider(user.image),
                    ),
                  ),
            label: "Tài khoản",
          ),
        ]);
  }

  void _navigate(BuildContext context, int route) {
    Navigator.of(context).canPop()
        ? Navigator.of(context).popAndPushNamed(_routes[route]!)
        : Navigator.of(context).pushNamed(_routes[route]!);
  }
}
