import 'school/school_body.dart';
import '../widgets/appbar.dart';
import '../widgets/bottom_nav.dart';
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
      body: SchoolBody(),
      bottomNavigationBar: BottomNav(
        index: BottomNav.SCHOOL_INDEX,
      ),
    );
  }
}
