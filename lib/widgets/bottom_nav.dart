import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  static const SCHOOL_INDEX = 0;
  static const TEACHER_INDEX = 1;
  static const HOME_INDEX = 2;
  static const EVENT_INDEX = 3;
  static const ASK_INDEX = 4;

  final int index;
  final List<String> tabs = ["/school", "/teacher", "/", "/event", "/ask"];

  BottomNav({this.index});

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
        items:  <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text("Học viện"),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            title: Text("Chuyên gia"),
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/home.png", fit: BoxFit.cover, width: 20.0, height: 20.0,) ,
            title: Text("Trang chủ"),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.event),
            title: Text("Lịch/Sự kiện"),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            title: Text("Học & Hỏi"),
          ),
        ]);
  }

  void _navigate(BuildContext context, int index) {
    if (index == this.index) {
      return;
    }
    if (index == HOME_INDEX) {
      return Navigator.of(context).popUntil(ModalRoute.withName("/"));
    }
    Navigator.of(context).canPop()
        ? Navigator.of(context).popAndPushNamed(this.tabs[index])
        : Navigator.of(context).pushNamed(this.tabs[index]);
  }
}
