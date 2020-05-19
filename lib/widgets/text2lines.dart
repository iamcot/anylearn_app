import 'package:flutter/material.dart';

class Text2Lines extends StatelessWidget {
  final String text;
  final double fontSize;

  const Text2Lines({Key key, this.text, this.fontSize = 14.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.normal),
      ),
    );
  }
}
