import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../dto/const.dart';
import '../dto/feature_data_dto.dart';
import '../dto/friend_params_dto.dart';

List<FeatureDataDTO>? defaultHomeFeatures(String role, int userId) {
  Map<String, List<FeatureDataDTO>> configs = {
    MyConst.ROLE_MEMBER: [
      FeatureDataDTO(
          icon: MdiIcons.qrcode, title: "Mã giới thiệu".tr(), route: "/qrcode", iconBg: "red", bg: Colors.blue[300]),
      FeatureDataDTO(
          icon: MdiIcons.accountGroup,
          title: "Bạn bè".tr(),
          route: "/account/friends",
          iconBg: "green",
          bg: Colors.green[600],
          routeParam: FriendParamsDTO(userId: userId, level: 1)),
      FeatureDataDTO(
          icon: MdiIcons.calendarClock,
          title: "Lịch học".tr(),
          route: "/account/calendar",
          iconBg: "orange",
          bg: Colors.blue[600]),
      FeatureDataDTO(
          icon: MdiIcons.piggyBank,
          title: "anyFoundation ",
          route: "/foundation",
          iconBg: "purple",
          bg: Colors.green[300]),
      ],
    MyConst.ROLE_TEACHER: [
      FeatureDataDTO(
          icon: MdiIcons.qrcode, title: "Mã giới thiệu".tr(), route: "/qrcode", iconBg: "red", bg: Colors.blue[300]),
      FeatureDataDTO(
          icon: MdiIcons.accountGroup,
          title: "Bạn bè".tr(),
          route: "/account/friends",
          bg: Colors.green[600],
          iconBg: "green",
          routeParam: FriendParamsDTO(userId: userId, level: 1)),
      FeatureDataDTO(
          icon: MdiIcons.calendarClock,
          title: "Lịch dạy".tr(),
          route: "/course/list",
          iconBg: "orange",
          bg: Colors.blue[600]),
      FeatureDataDTO(
          icon: MdiIcons.piggyBank,
          title: "anyFoundation ",
          route: "/foundation",
          iconBg: "purple",
          bg: Colors.green[300]),
    ],
    MyConst.ROLE_SCHOOL: [
      FeatureDataDTO(
          icon: MdiIcons.qrcode, title: "Mã giới thiệu".tr(), route: "/qrcode", iconBg: "red", bg: Colors.blue[300]),
      FeatureDataDTO(
          icon: MdiIcons.accountGroup,
          title: "Bạn bè".tr(),
          route: "/account/friends",
          bg: Colors.green[600],
          iconBg: "green",
          routeParam: FriendParamsDTO(userId: userId, level: 1)),
      FeatureDataDTO(
          icon: MdiIcons.calendarClock,
          title: "Lịch dạy".tr(),
          route: "/course/list",
          iconBg: "orange",
          bg: Colors.blue[600]),
      FeatureDataDTO(
          icon: MdiIcons.piggyBank,
          title: "anyFoundation ",
          route: "/foundation",
          iconBg: "purple",
          bg: Colors.green[300]),
    ],
    MyConst.ROLE_GUEST: [
      FeatureDataDTO(
          icon: MdiIcons.qrcode, title: "Mã giới thiệu".tr(), route: "/qrcode", iconBg: "red", bg: Colors.blue[300]),
      FeatureDataDTO(
          icon: MdiIcons.piggyBank,
          title: "anyFoundation",
          route: "/foundation",
          bg: Colors.green[600],
          iconBg: "green"),
      FeatureDataDTO(
          icon: MdiIcons.login, title: "Đăng nhập".tr(), route: "/login", iconBg: "orange", bg: Colors.blue[600]),
      FeatureDataDTO(
          icon: MdiIcons.lockOutline,
          title: "Đăng ký".tr(),
          route: "/register",
          iconBg: "purple",
          bg: Colors.green[300])
    ],
  };
  return configs.containsKey(role) ? configs[role] : configs[MyConst.ROLE_GUEST];
}
