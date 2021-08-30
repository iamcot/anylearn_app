import 'package:flutter/material.dart';

import '../../customs/custom_cached_image.dart';
import '../../customs/custom_carousel.dart';
import '../../dto/home_dto.dart';

class HomeClasses extends StatelessWidget {
  final List<HomeClassesDTO> blocks;

  HomeClasses({Key key, this.blocks}) : super(key: key);
  double width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    width = width * 2 / 3 - 10;
    return SliverToBoxAdapter(
      child: Container(child: Column(children: _buildList(context))),
    );
  }

  List<Widget> _buildList(BuildContext context) {
    return blocks
        .map(
          (block) => Container(
            padding: EdgeInsets.only(bottom: 20.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 15.0,
                  color: Colors.grey[100],
                ),
              ),
            ),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        block.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              CustomCarousel(
                items: block.classes,
                builderFunction: _itemSlider,
                height: width * 2 / 3,
                width: width,
              ),
            ]),
          ),
        )
        .toList();
  }

  Widget _itemSlider(BuildContext context, dynamic item, double cardHeight) {
    // double width = MediaQuery.of(context).size.width;
    // width = width * 2 / 3 - 10;
    final imgH = (width - 40) / 2;
    final imgW = (width - 40) / 2;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed("/pdp", arguments: item.id);
        },
        child: Stack(children: [
          Container(
              margin: EdgeInsets.only(top: 10, left: 10),
              child: ConstrainedBox(
                constraints: new BoxConstraints(
                  minHeight: imgH * 3 / 4,
                  maxWidth: width
                ),
                child: Card(
                  elevation: 0.5,
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: imgW, top: 5, right: 10, bottom: 5),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(
                          item.title,
                          style: TextStyle(fontWeight: FontWeight.w500),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        item.shortContent != null
                            ? Text(
                                item.shortContent,
                                maxLines: 4,
                                style: TextStyle(color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              )
                            : Text(""),
                      ])),
                ),
              )),
          Container(
            width: imgW,
            height: imgH,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: item.image != null && item.image.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: item.image != null ? CustomCachedImage(url: item.image) : Icon(Icons.broken_image),
                  )
                : SizedBox(
                    height: 60,
                    child: Icon(
                      Icons.school,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
          ),
        ]),
      ),
    );
  }
}
