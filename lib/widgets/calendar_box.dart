import 'package:anylearn/customs/custom_cached_image.dart';
import 'package:flutter/material.dart';

class CalendarBox extends StatelessWidget {
  final String text;
  final double fontSize;
  final String image;

  const CalendarBox({required this.text, this.fontSize: 20.0, this.image = ""});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 55.0,
      child: image == ""
          ? _dateBox()
          : CustomCachedImage(
              url: image,
              errorFallback: _dateBox(),
            ),
    );
  }

  Widget _dateBox() {
    return Stack(
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
    );
  }
}
