import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceBox extends StatelessWidget {
  final int orgPrice;
  final int price;
  final double fontSize;
  final bool showOrgPrice;

  const PriceBox({Key key, this.orgPrice = 0, this.price, this.fontSize = 16.0, this.showOrgPrice = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var f = new NumberFormat("###,###,###", "vi_VN");
    var of = new NumberFormat("-##%");
    return Row(
      children: <Widget>[
        orgPrice != null && orgPrice > price
            ? Container(
                padding: EdgeInsets.all(3.0),
                margin: EdgeInsets.only(right: 3),
                decoration: BoxDecoration(color: Colors.green[600], borderRadius: BorderRadius.circular(5)),
                child: Text(
                  of.format((orgPrice - price) / orgPrice),
                  style: TextStyle(color: Colors.white, fontSize: fontSize - 3.0, fontWeight: FontWeight.bold),
                ),
              )
            : Text(""),
        (!showOrgPrice || orgPrice == null || orgPrice <= price)
            ? Container()
            : Container(
                margin: EdgeInsets.only(right: 3),
                child: Text(
                  f.format(orgPrice),
                  style: TextStyle(
                    color: Colors.grey[500],
                    decoration: TextDecoration.lineThrough
                  ),
                ),
              ),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            f.format(price),
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.green[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
