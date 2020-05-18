import 'package:anylearn/dto/hot_items_dto.dart';
import 'package:anylearn/dto/item_dto.dart';
import 'package:anylearn/widgets/my_carousel.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
          title: "Học viện B",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/school"),
      new ItemDTO(
          title: "Cơ sở đào tạo C",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/school"),
    ]),
    new HotItemsDTO(title: "Chuyên gia nổi bật", route: "/school", list: [
      new ItemDTO(
          title: "Giảng viên A",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/school"),
      new ItemDTO(
          title: "Chuyên gia B",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/school"),
      new ItemDTO(
          title: "Thầy giáo C",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/school"),
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
        .map((hotList) => Container(
              child: MyCarousel(items: hotList.list, builderFunction: _itemSlider, height: 180.0),
            ))
        .toList();
  }

  Widget _itemSlider(BuildContext context, ItemDTO item) {
    double width = MediaQuery.of(context).size.width;
    width = width - width / 3;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(25)),
      child: Container(
        width: width,
        child: Column(
          children: [
            Image.network(item.image),
          ],
        )
      ),
    );
  }
}
