import 'package:flutter/material.dart';

class FeatureDataDTO {
  final IconData icon;
  final String title;
  final String route;
  final dynamic routeParam;
  final String iconImage;
  final String iconBg;
  final Color iconColor;

  FeatureDataDTO({this.icon, this.title, this.route, this.iconImage, this.iconBg, this.iconColor, this.routeParam});
}
