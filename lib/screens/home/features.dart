import 'package:anylearn/dto/feature_data_dto.dart';
import 'package:anylearn/screens/home/feature_icon.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FeatureList extends StatelessWidget {
  final List<FeatureDataDTO> features = [
    FeatureDataDTO(icon: MdiIcons.qrcode, title: "Mã Giới thiệu", route: "/qrcode"),
    FeatureDataDTO(icon: MdiIcons.accountGroup , title: "Bạn bè", route: "/teacher"),
    FeatureDataDTO(icon: MdiIcons.calendarClock, title: "Lịch học", route: "/event"),
    FeatureDataDTO(icon: MdiIcons.presentationPlay, title: "Tạo khóa học", route: "/developing"),
    FeatureDataDTO(icon: Icons.video_label, title: "Xem & Học", route: "/ask/cat"),
    FeatureDataDTO(icon: Icons.chrome_reader_mode, title: "Đọc & Học", route: "/ask/cat"),
    FeatureDataDTO(icon: Icons.question_answer, title: "Hỏi & Học", route: "/ask/cat"),
    FeatureDataDTO(icon: MdiIcons.piggyBank, title: "Quỹ học bổng", route: "/developing"),
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 4;
    return SliverPadding(
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: width,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 0.0,
            childAspectRatio: 1.5,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              FeatureDataDTO f = features[index];
              return Container(
                alignment: Alignment.center,
                child: FeatureIcon(
                  icon: f.icon,
                  iconSize: 40.0,
                  title: f.title,
                  route: f.route,
                ),
              );
            },
            childCount: features.length,
          ),
        ));
  }
}
