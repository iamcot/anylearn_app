import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../dto/feature_data_dto.dart';

class FeatureIcon2 extends StatelessWidget {
  final FeatureDataDTO featureData;
  final double iconSize;

  const FeatureIcon2({key, this.iconSize: 40.0, required this.featureData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: featureData.bg,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              featureData.icon,
              size: iconSize,
              color: Colors.white,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  featureData.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(featureData.route, arguments: featureData.routeParam);
      },
    );
  }
}
