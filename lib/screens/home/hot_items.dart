import 'package:anylearn/customs/custom_carousel.dart';
import 'package:anylearn/dto/hot_items_dto.dart';
import 'package:anylearn/dto/item_dto.dart';
import 'package:flutter/material.dart';

class HotItems extends StatelessWidget {
  final List<HotItemsDTO> hotItems = [
    new HotItemsDTO(title: "Trung tâm nổi bật", route: "/school", list: [
      new ItemDTO(
          title: "Trung tâm A",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/school"),
      new ItemDTO(
          title: "Trung tâm B có tên siêu dài cần cắt bớt đi cho đẹp",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/school"),
      new ItemDTO(
          title: "Trung tâm C",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/school"),
    ]),
    new HotItemsDTO(title: "Chuyên gia nổi bật", route: "/teacher", list: [
      new ItemDTO(
          title: "Giảng viên A có tên siêu dài cần phải cắt đi",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/teacher"),
      new ItemDTO(
          title: "Chuyên gia B",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/teacher"),
      new ItemDTO(
          title: "Thầy giáo C",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/teacher"),
    ]),
  ];
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
              CustomCarousel(items: hotList.list, builderFunction: _itemSlider, height: 170.0),
            ]),
          ),
        )
        .toList();
  }

  Widget _itemSlider(BuildContext context, ItemDTO item, double cardHeight) {
    double width = MediaQuery.of(context).size.width;
    width = width - width / 3;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(item.route);
      },
      child: Card(
        child: Container(
          alignment: Alignment.topLeft,
          width: width,
          child: Column(
            children: [
              Container(
                height: cardHeight * 2 / 3,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0), topRight: Radius.circular(7.0)),
                  child: Image.network(
                    item.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(15.0),
                child: Text(
                  item.title,
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
