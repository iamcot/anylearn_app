import '../main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  static const HOME_INDEX = 0;
  static const SOCIAL_INDEX = 1;
  static const MYCLASS_INDEX = 2;
  static const NOTI_INDEX = 3;
  static const ACCOUNT_INDEX = 4;

  static Map<int, String> _routes = {
    HOME_INDEX: "/",
    MYCLASS_INDEX: "/account/calendar",
    SOCIAL_INDEX: "/ask",
    NOTI_INDEX: "/notification",
    ACCOUNT_INDEX: "/account",
  };

  final int index;
  final String callback;

  BottomNav(this.index, {this.callback = ""});

  @override
  Widget build(BuildContext context) {
    return
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
            onTap: (i) => _navigate(context, i),
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
    if (route == index) {
      return;
    }
    Navigator.of(context).canPop()
        ? Navigator.of(context).popAndPushNamed(_routes[route]!)
        : Navigator.of(context).pushNamed(_routes[route]!);
  }
}
