import 'package:anylearn/dto/login_callback.dart';
import 'package:flutter/material.dart';

import '../dto/user_dto.dart';

class BottomNav extends StatelessWidget {
  static const HOME_INDEX = "/";
  static const SCHOOL_INDEX = "/school";
  static const TEACHER_INDEX = "/teacher";
  static const PROFILE_INDEX = "/profile";
  static const ASK_INDEX = "/ask";

  final String route;

  final UserDTO user;

  BottomNav({required this.route,required this.user});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 60.0,
            child: Text(""),
          ),
          IconButton(
              onPressed: () {
                _navigate(context, SCHOOL_INDEX);
              },
              icon: Icon(Icons.school, color: route == SCHOOL_INDEX ? Colors.green[600] : Colors.grey[500],)),
          IconButton(
              onPressed: () {
                _navigate(context, TEACHER_INDEX);
              },
              icon: Icon(Icons.supervised_user_circle, color: route == TEACHER_INDEX ? Colors.green[600] : Colors.grey[500],)),
          IconButton(
              onPressed: () {
                if (user.token != "") {
                  Navigator.of(context).canPop()
                      ? Navigator.of(context).popAndPushNamed("/profile", arguments: user.id)
                      : Navigator.of(context).pushNamed("/profile", arguments: user.id);
                } else {
                  Navigator.of(context).pushNamed("/login", arguments: LoginCallback(routeName: "/profile"));
                }
              },
              icon: Icon(Icons.account_circle, color: route == PROFILE_INDEX ? Colors.green[600] : Colors.grey[500],)),
          IconButton(
              onPressed: () {
                _navigate(context, ASK_INDEX);
              },
              icon: Icon(Icons.question_answer, color: route == ASK_INDEX ? Colors.green[600] : Colors.grey[500],)),
        ],
      ),
    );
    // BottomNavigationBar(
    //     type: BottomNavigationBarType.shifting,
    //     selectedItemColor: Colors.green[800],
    //     unselectedItemColor: Colors.black87,
    //     iconSize: 18.0,
    //     selectedFontSize: 10.0,
    //     unselectedFontSize: 10.0,
    //     currentIndex: this.index,
    //     onTap: (i) => _navigate(context, i),
    //     items: <BottomNavigationBarItem>[
    //       const BottomNavigationBarItem(
    //         icon: Icon(Icons.school),
    //         label: "Trường học",
    //       ),
    //       const BottomNavigationBarItem(
    //         icon: Icon(Icons.supervised_user_circle),
    //         label: "Chuyên gia",
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Image.asset(
    //           "assets/icons/home.png",
    //           fit: BoxFit.cover,
    //           width: 20.0,
    //           height: 20.0,
    //         ),
    //         label: "Trang chủ",
    //       ),
    //       const BottomNavigationBarItem(
    //         icon: Icon(Icons.question_answer),
    //         label: "Học & Hỏi",
    //       ),
    //       BottomNavigationBarItem(
    //         icon: user == null || user.image == null
    //             ? Icon(
    //                 Icons.account_circle,
    //               )
    //             : CircleAvatar(
    //                 radius: 14,
    //                 backgroundColor: Colors.white,
    //                 child: CircleAvatar(
    //                   radius: 12,
    //                   backgroundImage: CachedNetworkImageProvider(user.image),
    //                 ),
    //               ),
    //         label: "Tôi",
    //       ),
    //     ]);
  }

  void _navigate(BuildContext context, String route) {
    Navigator.of(context).canPop()
        ? Navigator.of(context).popAndPushNamed(route)
        : Navigator.of(context).pushNamed(route);
  }
}
