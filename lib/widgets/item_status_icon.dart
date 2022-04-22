import 'package:flutter/material.dart';

class ItemFavorStatusItem extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;

  const ItemFavorStatusItem({required this.text, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 5.0),
        child: Row(children: [
          Text(
            text + " ",
            style: TextStyle(color: Colors.black54),
          ),
          Icon(
            icon,
            color: color,
            size: 16.0,
          )
        ]));
  }
}
