import 'package:flutter/material.dart';

class Text2Lines extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final alignment;

  const Text2Lines({required this.text, this.fontSize = 14.0, this.fontWeight = FontWeight.normal, this.alignment = Alignment.topLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
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
