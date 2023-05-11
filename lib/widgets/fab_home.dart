import 'package:flutter/material.dart';

class FloatingActionButtonHome extends StatelessWidget {
  final isHome;

  const FloatingActionButtonHome({this.isHome = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: 60.0,
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: "homeBtn",
          backgroundColor: isHome != null && isHome ? Colors.white : Colors.grey[500],
          onPressed: () {
            return Navigator.of(context).popUntil(ModalRoute.withName("/"));
          },
          child: Image.asset("assets/images/logo_app_trans.png", fit: BoxFit.contain,),
          // elevation: 5.0,
        ),
      ),
    );
  }
}
