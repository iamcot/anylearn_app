import 'package:anylearn/widgets/appbar.dart';
import 'package:anylearn/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EventScreen();
}

class _EventScreen extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Lịch đào tạo & Sự kiện",
      ),
      body: Container(
        child: Text("Event Screen"),
      ),
      bottomNavigationBar: BottomNav(
        index: BottomNav.EVENT_INDEX,
      ),
    );
  }
}
