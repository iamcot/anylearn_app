import 'package:flutter/material.dart';

class HeaderButtonSection extends StatelessWidget {
  final Widget buttonOne;
  final Widget buttonTwo;
  final Widget buttonThree;
  HeaderButtonSection(
      {required this.buttonOne,
      required this.buttonTwo,
      required this.buttonThree});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buttonOne,
          buttonTwo,
          buttonThree,
        ],
      ),
    );
  }
}

Widget headerbutton({
  required String buttontext,
  required IconData buttonicon,
  required void Function() buttonaction,
  required Color buttoncolor,
}) {
  return TextButton.icon(
      onPressed: buttonaction,
      icon: Icon(
        buttonicon,
        color: buttoncolor,
      ),
      label: Text(
        buttontext,
        style: TextStyle(color: Colors.grey),
      ));
}
