import 'package:anylearn/assettest.dart';
import 'package:anylearn/widgets/avatar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class StatusSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Avatar(
      //   pic: sup,
      //   displayStatus: false,
      // ),
      title: TextField(
        decoration: InputDecoration(
            hintText: "Bạn đang nghĩ gì".tr(),
            hintStyle: TextStyle(
              color: Colors.black,
            ),
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none),
      ),
    );
  }
}
