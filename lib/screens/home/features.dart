import 'package:flutter/material.dart';

import '../../dto/feature_data_dto.dart';
import 'feature_icon.dart';

class FeatureList extends StatelessWidget {
  final List<FeatureDataDTO> features;

  const FeatureList({Key key, this.features}) : super(key: key);
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
            childAspectRatio: 1.2,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                child: FeatureIcon(
                  featureData: features[index],
                ),
              );
            },
            childCount: features.length,
          ),
        ));
  }
}
