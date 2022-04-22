import 'package:anylearn/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';

import '../../customs/custom_cached_image.dart';
import '../../customs/custom_carousel.dart';
import '../../dto/home_dto.dart';
import '../../widgets/price_box.dart';
import '../../widgets/rating.dart';

class HomeClasses extends StatelessWidget {
  final List<HomeClassesDTO> blocks;

  HomeClasses({key, required this.blocks}) : super(key: key);
  late double width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    width = width * 2 / 5 - 10;
    return SliverToBoxAdapter(
      child: Container(
          color: Colors.grey[200],
          child: Column(
              children: blocks
                  .map(
                    (block) => Container(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
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
                          height: width + 150,
                          width: width,
                        ),
                      ]),
                    ),
                  )
                  .toList())),
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
