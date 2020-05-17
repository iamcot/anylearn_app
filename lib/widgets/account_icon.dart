import 'package:flutter/material.dart';

class AccountIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10.0),
      child: IconButton(
          icon: Icon(
            Icons.account_circle,
            size: 32.0,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed("/account");
          }),
    );
  }
}
