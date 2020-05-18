import 'package:anylearn/dto/feature_data_dto.dart';
import 'package:anylearn/screens/home/feature_icon.dart';
import 'package:flutter/material.dart';

class FeatureList extends StatelessWidget {
  final List<FeatureDataDTO> features = [
    FeatureDataDTO(icon: Icons.school, title: "Học viện", route: "/school"),
    FeatureDataDTO(icon: Icons.supervised_user_circle , title: "Chuyên gia", route: "/teacher"),
    FeatureDataDTO(icon: Icons.event, title: "Lịch đào tạo", route: "/event"),
    FeatureDataDTO(icon: Icons.toys, title: "Dụng cụ", route: "/tool"),
    FeatureDataDTO(icon: Icons.video_label, title: "Xem & Học", route: "/ask"),
    FeatureDataDTO(icon: Icons.chrome_reader_mode, title: "Đọc & Học", route: "/ask"),
    FeatureDataDTO(icon: Icons.question_answer, title: "Hỏi & Học", route: "/ask"),
    FeatureDataDTO(icon: Icons.extension, title: "Học bổng", route: "/account"),
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 4;
    return SliverPadding(padding: EdgeInsets.only(top:20.0, bottom: 20.0),
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
    )) ;
  }
}