import 'dart:math';
import 'package:flutter/material.dart';

class RandomColor extends StatelessWidget {
  const RandomColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)
    );
  }
}