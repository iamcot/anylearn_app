import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String data;
  final double size;
  const TitleText(this.data, {Key? key, this.size = 18}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(data, style: TextStyle(fontSize: size, fontWeight: FontWeight.bold));
  }
}