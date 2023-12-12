import 'package:flutter/material.dart';

class ItemSchedule extends StatelessWidget {
  final int data;
  const ItemSchedule(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      margin: EdgeInsets.only(right: 20),
      color: Colors.purple.shade200,
      child: Text(data.toString()),
    );
  }
}