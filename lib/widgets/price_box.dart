import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceBox extends StatelessWidget {
  final int orgPrice;
  final int price;
  final double fontSize;

  const PriceBox({Key key, this.orgPrice = 0, this.price, this.fontSize = 16.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var f = new NumberFormat("###,###,###", "vi_VN");
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            f.format(price),
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        orgPrice > 0.0
            ? Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 5.0),
                child: Text(
                  f.format(orgPrice),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: fontSize - 2.0,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              )
            : Text(""),
      ],
    );
  }
}
