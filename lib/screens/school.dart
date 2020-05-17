import 'package:anylearn/widgets/appbar.dart';
import 'package:anylearn/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

class SchoolScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SchoolScreen();
}

class _SchoolScreen extends State<SchoolScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Học viện & Trung tâm đào tạo",
      ),
      body: Container(
        child: Text("School Screen"),
      ),
      bottomNavigationBar: BottomNav(
        index: BottomNav.SCHOOL_INDEX,
      ),
    );
  }
}
