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
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Xin chào " + (user == null ? "" : user.name) + "!",
              style: TextStyle(fontSize: 12.0),
            ),
            padding: EdgeInsets.all(10.0),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 0.1))),
          ),
          Container(
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
          ),
        ],
      ),
    );
  }
}
