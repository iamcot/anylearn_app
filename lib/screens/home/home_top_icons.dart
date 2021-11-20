import 'package:flutter/material.dart';

import '../../dto/const.dart';
import '../../dto/feature_data_dto.dart';
import '../../dto/user_dto.dart';
import '../../models/default_feature_data.dart';
import 'feature_icon.dart';

class HomeTopIcons extends StatelessWidget {
  final UserDTO user;

  const HomeTopIcons({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<FeatureDataDTO> icons =
        defaultHomeFeatures(user == null ? MyConst.ROLE_GUEST : user.role, user == null ? null : user.id);
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        children: icons?.map((e) {
          return Expanded(
            child: FeatureIcon(
              featureData: e,
              iconSize: 32.0,
            ),
          );
        }).toList(),
      ),
    );
  }
}
