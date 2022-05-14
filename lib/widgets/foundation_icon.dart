import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FoundationIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 0.0),
      child: IconButton(
        icon: Icon(
          MdiIcons.piggyBank,
          size: 24.0,
          color: Colors.grey,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('/foundation');
        },
      ),
    );
  }
}
