import 'package:anylearn/widgets/appbar.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Thông báo",
        hasBack: true,
        screen: "notification",
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text("Trang này đang được hoàn thiện."),
      ),
    );
  }
}
