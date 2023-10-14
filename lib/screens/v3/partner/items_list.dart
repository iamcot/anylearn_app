import 'package:flutter/material.dart';

import '../../../customs/custom_cached_image.dart';
import '../../../dto/item_dto.dart';

class ItemsList extends StatelessWidget {
  final List<ItemDTO> items;
  const ItemsList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? Container()
        : Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: _itemBuilder),
          );
  }

  Widget _itemBuilder(BuildContext context, index) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          leading: Container(
            width: 85,
            height: 85,
            child: CustomCachedImage(url: items[index].image, borderRadius: 10.0),
          ),
          title: Text(items[index].title),
          subtitle: Text(
            items[index].shortContent,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          trailing: Icon(Icons.chevron_right_rounded),
          onTap: () => Navigator.of(context).pushNamed('/pdp', arguments: items[index].id),
        ));
  }
}
