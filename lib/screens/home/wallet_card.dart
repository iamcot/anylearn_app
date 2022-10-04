import 'package:anylearn/dto/feature_data_dto.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'feature_icon.dart';

class WalletCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        Text('title');

    return Card(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Tài khoản của tôi",
              style: TextStyle(fontSize: 12.0),
            ).tr(),
            padding: EdgeInsets.all(10.0),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 0.1))),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: FeatureIcon(
                    featureData: FeatureDataDTO(icon: Icons.input , title: "Nạp tiền".tr(), route: "/deposit", iconColor: Colors.green),
                    iconSize: 24.0,
                  ),
                ),
                Expanded(
                  child: FeatureIcon(
                    featureData:
                        FeatureDataDTO(icon: Icons.monetization_on, title: "Rút tiền".tr(), route: "/withdraw", iconColor: Colors.purple),
                    iconSize: 24.0,
                  ),
                ),
                Expanded(
                  child: FeatureIcon(
                    featureData: FeatureDataDTO(icon: MdiIcons.gift , title: "Điểm".tr(), route: "/exchange", iconColor: Colors.orange),
                    iconSize: 24.0,
                  ),
                ),
                Expanded(
                  child: FeatureIcon(
                    featureData: FeatureDataDTO(icon: Icons.receipt, title: "Giao dịch".tr(), route: "/transaction", iconColor: Colors.blue),
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
