import 'package:anylearn/dto/item_dto.dart';
import 'package:anylearn/dto/v3/listing_dto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListingCardItem extends StatelessWidget {
  final double width;
  final ListingResultDTO data;
  const ListingCardItem({Key? key, required this.data, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Container(
            height: width + 75,
            child: ListView.builder(
              physics: ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: data.items.length,
              itemBuilder: (context, index) => _itemBuilder(context, data.items[index], width),
            )),
      ),
    ]);
  }

  Widget _itemBuilder(BuildContext context, ItemDTO item, double width) {
    final f = new NumberFormat("###,###,###", "vi_VN");
    return Container(
      margin: EdgeInsets.only(right: 15),
      width: width,
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed("/pdp", arguments: item.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: item.image,
                fit: BoxFit.cover,
                width: width,
                height: width - 5,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: Text(item.title, maxLines: 3, style: TextStyle(
                fontSize: 14
              ),),
            ),
            Text(
              '${f.format(item.price)}',
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
