import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddCourseIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(
          MdiIcons.newspaperPlus ,
          size: 24.0,
        ),
        onPressed: () {
        },
      ),
    );
  }
}
