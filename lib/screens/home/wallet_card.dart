import 'package:anylearn/screens/home/feature_icon.dart';
import 'package:flutter/material.dart';

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
                    icon: Icons.input,
                    title: "Nạp tiền",
                    route: "/account/deposit",
                  ),
                ),
                Expanded(
                  child: FeatureIcon(
                    icon: Icons.monetization_on,
                    title: "Rút tiền",
                    route: "/account/withdraw",
                  ),
                ),
                Expanded(
                  child: FeatureIcon(
                    icon: Icons.card_giftcard,
                    title: "Điểm",
                    route: "/account/commission",
                  ),
                ),
                Expanded(
                  child: FeatureIcon(
                    icon: Icons.receipt,
                    title: "Giao dịch",
                    route: "/account/transaction",
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
