import 'package:anylearn/widgets/appbar.dart';
import 'package:anylearn/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

class TeacherScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeacherScreen();
}

class _TeacherScreen extends State<TeacherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Giảng viên & Chuyên gia",
      ),
      body: Container(
        child: Text("Teacher Screen"),
      ),
      bottomNavigationBar: BottomNav(
        index: BottomNav.TEACHER_INDEX,
      ),
    );
  }
}
