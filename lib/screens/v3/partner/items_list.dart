import 'package:anylearn/customs/custom_cached_image.dart';
import 'package:anylearn/dto/item_dto.dart';
import 'package:flutter/material.dart';

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
          physics:  NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: _itemBuilder
        ),
      );
  }

  Widget _itemBuilder(BuildContext context, index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed('/pdp', arguments: items[index].id),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    items[index].title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      items[index].shortContent,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  
                ],
              ),
              
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              width: 110,
              height: 85,
              child: CustomCachedImage(url: items[index].image, borderRadius: 10.0),
            ),
          
          ],
        ),
      ),
    );

  }
}