import 'package:anylearn/dto/item_dto.dart';
import 'package:anylearn/screens/v3/home/item_card.dart';
import 'package:flutter/material.dart';

class ItemsGrid extends StatelessWidget {
  final List<ItemDTO> items;
  const ItemsGrid({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
      ? Container()
      : Container(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          childAspectRatio: 100/120
        ),
        itemCount: items.length, 
        itemBuilder: ((context, index) => _itemBuilder(context, index)),
      )
    );
  }

  Widget _itemBuilder(BuildContext context, index) {
    return Container(
      //color: Colors.grey,
      //padding: EdgeInsets.all(8),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed('/pdp', arguments: items[index].id),
        child: ItemCard(item: items[index], width: 125)
      ),
    );
  }
}