import 'package:flutter/material.dart';

import '../customs/custom_scroll_physical.dart';

class CustomCarousel extends StatelessWidget {
  CustomCarousel({
    Key key,
    @required this.items,
    @required this.builderFunction,
    @required this.height,
    this.dividerIndent = 10,
    this.width,
  }) : super(key: key);

  final List<dynamic> items;
  final double dividerIndent;
  final Function(BuildContext context, dynamic item, double cardHeight) builderFunction;
  final double height;
  final width;

  @override
  Widget build(BuildContext context) {
    double _width = width;
    if (_width == null) {
      _width = MediaQuery.of(context).size.width;
      _width = _width * 2 / 3 - 10 + this.dividerIndent;
    }

    return Container(
      alignment: Alignment.topCenter,
      height: height,
      child: ListView.separated(
          physics: CustomScrollPhysics(itemDimension: 100),
          primary: false,
          separatorBuilder: (context, index) => Divider(
                indent: dividerIndent,
              ),
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) {
            Widget item = builderFunction(context, items[index], this.height);
            if (index == 0) {
              return Padding(
                child: item,
                padding: EdgeInsets.only(left: dividerIndent),
              );
            } else if (index == items.length - 1) {
              return Padding(
                child: item,
                padding: EdgeInsets.only(right: dividerIndent),
              );
            }
            return item;
          }),
    );
  }
}
