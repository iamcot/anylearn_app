import 'package:flutter/material.dart';

import '../../dto/feature_data_dto.dart';

class FeatureIcon extends StatelessWidget {
  final FeatureDataDTO featureData;
  final double iconSize;

  const FeatureIcon({Key key, this.iconSize: 40.0, this.featureData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          featureData.icon != null
              ? (featureData.iconBg != null
                  ? Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/bg/" + featureData.iconBg + ".png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Icon(
                        featureData.icon,
                        size: (iconSize - 15.0),
                        color: Colors.white,
                      ),
                    )
                  : Icon(
                      featureData.icon,
                      size: iconSize,
                      color: featureData.iconColor ?? Colors.grey[800],
                    ))
              : Container(
                  height: iconSize,
                  width: iconSize,
                  child: Image.network(
                    featureData.iconImage,
                    fit: BoxFit.cover,
                  )),
          Container(
            padding: EdgeInsets.only(top: 5.0),
            alignment: Alignment.center,
            child: Text(
              featureData.title,
              style: TextStyle(fontSize: 10.0, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(featureData.route, arguments: featureData.routeParam);
      },
    );
  }
}
