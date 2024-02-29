import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  final Widget body;
  final double? fontSize;

  const DefaultScaffold({Key? key, required this.body, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTextStyle(
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.grey.shade800,
          fontSize: fontSize ?? 14.0,
        ),
        child: body
      ),
    );
  }
}