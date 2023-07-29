import 'package:flutter/material.dart';

import '../../../customs/custom_carousel.dart';
import '../../../dto/v3/home_dto.dart';
import 'item_card.dart';

class HomeClasses extends StatelessWidget {
  final List<HomeClassesDTO> blocks;

  HomeClasses({key, required this.blocks}) : super(key: key);
  late double width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    width = width * 2 / 5 - 10;
    return Container(
      child: Column(
          children: blocks
              .map(
                (block) => Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 10.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              block.title.toUpperCase(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomCarousel(
                      items: block.classes,
                      builderFunction: _itemSlider,
                      height: width + 90,
                      width: width,
                    ),
                  ]),
                ),
              )
              .toList()),
    );
  }

  Widget _itemSlider(BuildContext context, dynamic item, double cardHeight) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed("/pdp", arguments: item.id);
        },
        child: Container(
          width: width,
          child: ItemCard(
            item: item,
            width: width,
          ),
        ),
      ),
    );
  }
}
