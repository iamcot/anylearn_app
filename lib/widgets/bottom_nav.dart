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
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black54,
        iconSize: 18.0,
        selectedFontSize: 11.0,
        unselectedFontSize: 10.0,
        currentIndex: this.index,
        onTap: (i) => _navigate(context, i),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text("Học viện"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            title: Text("Chuyên gia"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Trang chủ"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            title: Text("Lịch/Sự kiện"),
          ),
          BottomNavigationBarItem(
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
