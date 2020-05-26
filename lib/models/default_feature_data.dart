import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../dto/const.dart';
import '../dto/feature_data_dto.dart';

List<FeatureDataDTO> defaultHomeFeatures(String role) {
  Map<String, List<FeatureDataDTO>> configs = {
    MyConst.ROLE_MEMBER: [
      FeatureDataDTO(icon: MdiIcons.qrcode, title: "Mã Giới thiệu", route: "/qrcode", iconBg: "red"),
      FeatureDataDTO(icon: MdiIcons.accountGroup, title: "Bạn bè", route: "/account/friends", iconBg: "blue"),
      FeatureDataDTO(icon: MdiIcons.calendarClock, title: "Lịch học", route: "/account/calendar", iconBg: "green"),
      FeatureDataDTO(icon: MdiIcons.searchWeb, title: "Tìm khóa học", route: "/all", iconBg: "pink"),
      FeatureDataDTO(icon: Icons.video_label, title: "Xem & Học", route: "/ask/cat"),
      FeatureDataDTO(icon: Icons.chrome_reader_mode, title: "Đọc & Học", route: "/login"),
      FeatureDataDTO(icon: Icons.question_answer, title: "Hỏi & Học", route: "/ask/cat"),
      FeatureDataDTO(icon: MdiIcons.piggyBank, title: "Quỹ học bổng", route: "/developing"),
    ],
    MyConst.ROLE_TEACHER: [
      FeatureDataDTO(icon: MdiIcons.qrcode, title: "Mã Giới thiệu", route: "/qrcode"),
      FeatureDataDTO(icon: MdiIcons.accountGroup, title: "Bạn bè", route: "/account/friends"),
      FeatureDataDTO(icon: MdiIcons.calendarClock, title: "Lịch dạy", route: "/account/calendar"),
      FeatureDataDTO(icon: MdiIcons.presentation, title: "Tạo khóa học", route: "/course/create"),
      FeatureDataDTO(icon: Icons.video_label, title: "Xem & Học", route: "/ask/cat"),
      FeatureDataDTO(icon: Icons.chrome_reader_mode, title: "Đọc & Học", route: "/login"),
      FeatureDataDTO(icon: Icons.question_answer, title: "Hỏi & Học", route: "/ask/cat"),
      FeatureDataDTO(icon: MdiIcons.piggyBank, title: "Quỹ học bổng", route: "/developing"),
    ],
    MyConst.ROLE_SCHOOL: [
      FeatureDataDTO(icon: MdiIcons.qrcode, title: "Mã Giới thiệu", route: "/qrcode"),
      FeatureDataDTO(icon: MdiIcons.accountGroup, title: "Bạn bè", route: "/account/friends"),
      FeatureDataDTO(icon: MdiIcons.calendarClock, title: "Lịch học", route: "/account/calendar"),
      FeatureDataDTO(icon: MdiIcons.toolbox, title: "Tạo khóa học", route: "/course/create"),
      FeatureDataDTO(icon: Icons.video_label, title: "Xem & Học", route: "/ask/cat"),
      FeatureDataDTO(icon: Icons.chrome_reader_mode, title: "Đọc & Học", route: "/login"),
      FeatureDataDTO(icon: Icons.question_answer, title: "Hỏi & Học", route: "/ask/cat"),
      FeatureDataDTO(icon: MdiIcons.piggyBank, title: "Quỹ học bổng", route: "/developing"),
    ],
     MyConst.ROLE_GUEST: [
      FeatureDataDTO(icon: MdiIcons.qrcode, title: "Mã Giới thiệu", route: "/qrcode", iconBg: "red"),
      FeatureDataDTO(icon: MdiIcons.accountGroup, title: "Bạn bè", route: "/account/friends", iconBg: "blue"),
      FeatureDataDTO(icon: MdiIcons.login, title: "Đăng nhập", route: "/login", iconBg: "green"),
      FeatureDataDTO(icon: MdiIcons.lockOutline, title: "Đăng ký", route: "/register", iconBg: "pink"),
      // FeatureDataDTO(icon: Icons.video_label, title: "Xem & Học", route: "/ask/cat"),
      // FeatureDataDTO(icon: Icons.chrome_reader_mode, title: "Đọc & Học", route: "/login"),
      // FeatureDataDTO(icon: Icons.question_answer, title: "Hỏi & Học", route: "/ask/cat"),
      // FeatureDataDTO(icon: MdiIcons.piggyBank, title: "Quỹ học bổng", route: "/developing"),
    ],
  };
  return configs[role] ?? configs[MyConst.ROLE_MEMBER];
}
