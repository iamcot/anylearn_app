import 'package:flutter/material.dart';

import '../customs/custom_scroll_physical.dart';

class CustomCarousel extends StatelessWidget {
  CustomCarousel({
    Key key,
    @required this.items,
    @required this.builderFunction,
    @required this.height,
    this.dividerIndent = 10,
  }) : super(key: key);

  final List<dynamic> items;
  final double dividerIndent;
  final Function(BuildContext context, dynamic item, double cardHeight) builderFunction;
  final double height;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    width = width * 2 / 5 - 10 + this.dividerIndent;
    return Container(
      alignment: Alignment.topCenter,
      height: height,
      child: ListView.separated(
          physics: CustomScrollPhysics(itemDimension: width),
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
