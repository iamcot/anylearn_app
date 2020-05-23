import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../dto/const.dart';
import '../dto/user_dto.dart';

class AddCourseIcon extends StatelessWidget {
  final UserDTO user;

  const AddCourseIcon({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: user != null && user.role != MyConst.ROLE_MEMBER
          ? IconButton(
              icon: Icon(
                MdiIcons.newspaperPlus,
                size: 24.0,
              ),
              onPressed: () {},
            )
          : null,
    );
  }
}
