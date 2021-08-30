import 'package:anylearn/dto/login_callback.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../dto/user_dto.dart';

class BottomNav extends StatelessWidget {
  static const SCHOOL_INDEX = 0;
  static const TEACHER_INDEX = 1;
  static const HOME_INDEX = 2;
  static const EVENT_INDEX = 4;
  static const ASK_INDEX = 3;

  final int index;
  final List<String> tabs = ["/school", "/teacher", "/", "/ask", "/profile"];
  final UserDTO user;

  BottomNav({this.index, this.user});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.black87,
        iconSize: 18.0,
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        currentIndex: this.index,
        onTap: (i) => _navigate(context, i),
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: "Trường học",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: "Chuyên gia",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/home.png",
              fit: BoxFit.cover,
              width: 20.0,
              height: 20.0,
            ),
            label: "Trang chủ",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: "Học & Hỏi",
          ),
          BottomNavigationBarItem(
            icon: user == null || user.image == null
                ? Icon(
                    Icons.account_circle,
                  )
                : CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundImage: CachedNetworkImageProvider(user.image),
                    ),
                  ),
            label: "Tôi",
          ),
        ]);
  }

  void _navigate(BuildContext context, int index) {
    if (index == this.index) {
      return;
    }
    if (index == HOME_INDEX) {
      return Navigator.of(context).popUntil(ModalRoute.withName("/"));
    } else if (index == EVENT_INDEX) {
      if (user != null) {
        Navigator.of(context).pushNamed("/profile", arguments: user.id);
      } else {
        Navigator.of(context).pushNamed("/login", arguments: LoginCallback(routeName: "/profile"));
      }
    } else {
      Navigator.of(context).canPop()
          ? Navigator.of(context).popAndPushNamed(this.tabs[index])
          : Navigator.of(context).pushNamed(this.tabs[index]);
    }
  }
}
