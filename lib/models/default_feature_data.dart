import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../dto/const.dart';
import '../dto/feature_data_dto.dart';

List<FeatureDataDTO> defaultHomeFeatures(String role, int userId) {
  Map<String, List<FeatureDataDTO>> configs = {
    MyConst.ROLE_MEMBER: [
      FeatureDataDTO(icon: MdiIcons.qrcode, title: "Mã Giới thiệu", route: "/qrcode", iconBg: "red"),
      FeatureDataDTO(icon: MdiIcons.accountGroup, title: "Bạn bè", route: "/account/friends", iconBg: "green", routeParam: userId),
      FeatureDataDTO(icon: MdiIcons.calendarClock, title: "Lịch học", route: "/account/calendar", iconBg: "orange"),
      FeatureDataDTO(icon: MdiIcons.searchWeb, title: "Tìm khóa học", route: "/all", iconBg: "purple"),
      FeatureDataDTO(icon: Icons.video_label, title: "Xem Để Học", route: "/ask", iconBg: "blue"),
      FeatureDataDTO(icon: Icons.chrome_reader_mode, title: "Đọc Để Học", route: "/ask", iconBg: "yellow"),
      FeatureDataDTO(icon: Icons.question_answer, title: "Hỏi Để Học", route: "/developing", iconBg: "cyan"),
      FeatureDataDTO(icon: MdiIcons.handHeart, title: "Quỹ học bổng", route: "/developing", iconBg: "pink"),
    ],
    MyConst.ROLE_TEACHER: [
      FeatureDataDTO(icon: MdiIcons.qrcode, title: "Mã Giới thiệu", route: "/qrcode", iconBg: "red"),
      FeatureDataDTO(icon: MdiIcons.accountGroup, title: "Bạn bè", route: "/account/friends", iconBg: "green", routeParam: userId),
      FeatureDataDTO(icon: MdiIcons.calendarClock, title: "Lịch dạy", route: "/course/list", iconBg: "orange"),
      FeatureDataDTO(icon: MdiIcons.presentation, title: "Tạo khóa học", route: "/course/form", iconBg: "purple"),
      FeatureDataDTO(icon: Icons.video_label, title: "Xem Để Học", route: "/ask", iconBg: "blue"),
      FeatureDataDTO(icon: Icons.chrome_reader_mode, title: "Đọc Để Học", route: "/ask", iconBg: "yellow"),
      FeatureDataDTO(icon: Icons.question_answer, title: "Hỏi Để Học", route: "/developing", iconBg: "cyan"),
      FeatureDataDTO(icon: MdiIcons.handHeart, title: "Quỹ học bổng", route: "/developing", iconBg: "pink"),
    ],
    MyConst.ROLE_SCHOOL: [
      FeatureDataDTO(icon: MdiIcons.qrcode, title: "Mã Giới thiệu", route: "/qrcode", iconBg: "red"),
      FeatureDataDTO(icon: MdiIcons.accountGroup, title: "Bạn bè", route: "/account/friends", iconBg: "green", routeParam: userId),
      FeatureDataDTO(icon: MdiIcons.calendarClock, title: "Lịch dạy", route: "/course/list", iconBg: "orange"),
      FeatureDataDTO(icon: MdiIcons.toolbox, title: "Tạo khóa học", route: "/course/form", iconBg: "purple"),
      FeatureDataDTO(icon: Icons.video_label, title: "Xem Để Học", route: "/ask", iconBg: "blue"),
      FeatureDataDTO(icon: Icons.chrome_reader_mode, title: "Đọc Để Học", route: "/ask", iconBg: "yellow"),
      FeatureDataDTO(icon: Icons.question_answer, title: "Hỏi Để Học", route: "/developing", iconBg: "cyan"),
      FeatureDataDTO(icon: MdiIcons.handHeart, title: "Quỹ học bổng", route: "/developing", iconBg: "pink"),
    ],
     MyConst.ROLE_GUEST: [
      FeatureDataDTO(icon: MdiIcons.qrcode, title: "Mã Giới thiệu", route: "/qrcode", iconBg: "red"),
      FeatureDataDTO(icon: MdiIcons.accountGroup, title: "Bạn bè", route: "/account/friends", iconBg: "green", routeParam: userId),
      FeatureDataDTO(icon: MdiIcons.login, title: "Đăng nhập", route: "/login", iconBg: "orange"),
      FeatureDataDTO(icon: MdiIcons.lockOutline, title: "Đăng ký", route: "/register", iconBg: "purple"),
      FeatureDataDTO(icon: Icons.video_label, title: "Xem Để Học", route: "/ask", iconBg: "blue"),
      FeatureDataDTO(icon: Icons.chrome_reader_mode, title: "Đọc Để Học", route: "/ask", iconBg: "yellow"),
      FeatureDataDTO(icon: Icons.question_answer, title: "Hỏi Để Học", route: "/developing", iconBg: "cyan"),
      FeatureDataDTO(icon: MdiIcons.handHeart, title: "Quỹ học bổng", route: "/developing", iconBg: "pink"),
    ],
  };
  return configs[role] ?? configs[MyConst.ROLE_MEMBER];
}
