import 'package:anylearn/screens/home/exit_confirm.dart';
import 'package:anylearn/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'home/home_body.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _willExit,
        child: Scaffold(
          body: new HomeBody(),
          bottomNavigationBar: BottomNav(
            index: BottomNav.HOME_INDEX,
          ),
        ));
  }

  Future<bool> _willExit() async {
    return await showDialog(context: context, builder: (context) => new ExitConfirm());
  }
}
