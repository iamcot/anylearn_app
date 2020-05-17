import 'package:anylearn/widgets/appbar.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountScreen();
}

class _AccountScreen extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Tài khoản",
        screen: "account",
      ),
      body: Container(
        child: Text("Tài khoản"),
      ),
    );
  }
}
