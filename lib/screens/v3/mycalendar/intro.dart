import 'package:flutter/material.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 22,
          ),
          children: [
            TextSpan(text: 'Chào Name O.o \n'),
            TextSpan(text: 'Bạn có 3 lớp học hôm nay.'),
          ]
        ),
      )
    );
  }
}