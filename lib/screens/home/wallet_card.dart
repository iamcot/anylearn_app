import 'package:anylearn/dto/feature_data_dto.dart';
import 'package:flutter/material.dart';

import 'feature_icon.dart';

class WalletCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Ví của tôi",
              style: TextStyle(fontSize: 12.0),
            ),
            padding: EdgeInsets.all(10.0),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 0.1))),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: FeatureIcon(
                    featureData: FeatureDataDTO(icon: Icons.input, title: "Nạp tiền", route: "/deposit"),
                    iconSize: 24.0,
                  ),
                ),
                Expanded(
                  child: FeatureIcon(
                    featureData:
                        FeatureDataDTO(icon: Icons.monetization_on, title: "Rút tiền", route: "/withdraw"),
                    iconSize: 24.0,
                  ),
                ),
                Expanded(
                  child: FeatureIcon(
                    featureData: FeatureDataDTO(icon: Icons.card_giftcard, title: "Điểm", route: "/commission"),
                    iconSize: 24.0,
                  ),
                ),
                Expanded(
                  child: FeatureIcon(
                    featureData: FeatureDataDTO(icon: Icons.receipt, title: "Giao dịch", route: "/transaction"),
                    iconSize: 24.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
