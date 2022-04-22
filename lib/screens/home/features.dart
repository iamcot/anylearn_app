import 'package:flutter/material.dart';

import '../../dto/feature_data_dto.dart';
import 'feature_icon2.dart';

class FeatureList extends StatelessWidget {
  final List<FeatureDataDTO> features;

  const FeatureList({key, required this.features}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    return SliverPadding(
        padding: EdgeInsets.only(bottom: 10.0),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: width,
            childAspectRatio: 2.8,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                child: FeatureIcon2(
                  featureData: features[index],
                ),
              );
            },
            childCount: features.length,
          ),
        ));
  }
}
