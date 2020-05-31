import 'package:flutter/material.dart';

class CalendarBox extends StatelessWidget {
  final String text;
  final double fontSize;
  final String image;

  const CalendarBox({Key key, this.text, this.fontSize: 20.0, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
        width: 55.0,
        child: image == null ? Stack(
          children: <Widget>[
            Image.asset(
              "assets/images/date_bg.png",
              fit: BoxFit.fitHeight,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 15.0),
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
        ) : Image.network(image),
        );
  }
}
