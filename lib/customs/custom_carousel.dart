import 'package:anylearn/customs/custom_scroll_physical.dart';
import 'package:anylearn/dto/item_dto.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatelessWidget {
  CustomCarousel({
    Key key,
    @required this.items,
    @required this.builderFunction,
    @required this.height,
    this.dividerIndent = 20,
  }) : super(key: key);

  final List<dynamic> items;
  final double dividerIndent;
  final Function(BuildContext context, ItemDTO item, double cardHeight) builderFunction;
  final double height;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    width = width - width / 3 + this.dividerIndent + 10;
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
