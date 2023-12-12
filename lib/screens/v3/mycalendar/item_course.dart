import 'package:flutter/material.dart';

class ItemCourse extends StatelessWidget {
  final int data;
  ItemCourse(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Container(
      width: 150,
      margin: EdgeInsets.only(right: 10),
      color: Colors.orange.shade200,
      child: Text(data.toString()),
    );
  }
}