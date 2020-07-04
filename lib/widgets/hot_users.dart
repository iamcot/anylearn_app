import 'package:flutter/material.dart';

import '../customs/custom_carousel.dart';
import '../dto/hot_users_dto.dart';

class HotUsers extends StatelessWidget {
  final List<HotUsersDTO> hotItems;

  const HotUsers({Key key, this.hotItems}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(child: Column(children: _buildList(context))),
    );
  }

  List<Widget> _buildList(BuildContext context) {
    return hotItems
        .map(
          (hotList) => Container(
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
                        hotList.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(hotList.route);
                          },
                          child: Text(
                            "Tất cả",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              CustomCarousel(items: hotList.list, builderFunction: _itemSlider, height: 140.0),
            ]),
          ),
        )
        .toList();
  }

  Widget _itemSlider(BuildContext context, dynamic item, double cardHeight) {
    double width = MediaQuery.of(context).size.width;
    width = width * 2 / 5 - 10;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("/items/" + item.role, arguments: item.id);
      },
      child: Card(
        child: Container(
          alignment: Alignment.topLeft,
          width: width,
          child: Column(
            children: [
              Container(
                height: cardHeight * 3 / 5,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0), topRight: Radius.circular(7.0)),
                  child: item.image != null && item.image.isNotEmpty
                      ? Image.network(
                          item.banner ?? item.image,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.broken_image),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(15.0),
                child: Text(
                  item.name ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
