import 'package:flutter/material.dart';

class CalendarBox extends StatelessWidget {
  final String text;
  final double fontSize;

  const CalendarBox({Key key, this.text, this.fontSize: 24.0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50.0,
        child: Stack(
          children: <Widget>[
            Image.asset(
              "assets/images/date_bg.png",
              fit: BoxFit.fitHeight,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                text,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
              ),
            )
          ],
        ));
  }
}
