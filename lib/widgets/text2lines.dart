import 'package:flutter/material.dart';

class Text2Lines extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const Text2Lines({Key key, this.text, this.fontSize = 14.0, this.fontWeight = FontWeight.normal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        text,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }
}
