import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconPostShare extends StatelessWidget {
  const IconPostShare({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(0, 78, 76, 76),
      padding: const EdgeInsets.all(8),
      child: const Icon(Icons.screen_share_outlined),
    );
  }
}
