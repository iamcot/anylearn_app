import 'package:flutter/material.dart';

class RatingBox extends StatelessWidget {
  final double score;
  final int max = 5;
  final double fontSize;
  final String alignment;

  const RatingBox({Key key, this.score, this.fontSize = 14.0, this.alignment: "center"}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: this.alignment == "center" ?  MainAxisAlignment.center : MainAxisAlignment.start ,
        children: _buildStar(),
      ),
    );
  }

  List<Widget> _buildStar() {
    List<Widget> list = [];
    double current = 0;
    if (score == null) {
      return [];
    }
    while (current < score) {
      list.add(Padding(
        padding: EdgeInsets.all(0.0),
        child: Icon(Icons.star, color: Colors.orange, size: fontSize,),
      ));
      current += 1.0;
    }
    if (score < current && score > current - 1) {
      list.add(Padding(
        padding: EdgeInsets.all(0.0),
        child: Icon(Icons.star_half, color: Colors.orange, size: fontSize),
      ));
      current += 1.0;
    }
    while (current < max) {
      list.add(Padding(
        padding: EdgeInsets.all(0.0),
        child: Icon(Icons.star_border, color: Colors.grey, size: fontSize),
      ));
      current += 1.0;
    }
    return list;
  }
}
