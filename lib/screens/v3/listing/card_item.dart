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
          height: width + 80 ,
          child: ListView.builder(
            physics: ScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: data.items.length,
            itemBuilder: (context, index) => _itemBuilder(data.items[index], width),
          )
        ),
      ),
    ]);
  }

  Widget _itemBuilder(ItemDTO item, double width) {
    final f = new NumberFormat("###,###,###", "vi_VN");
    return Container(
      margin: EdgeInsets.only(right: 15),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: item.image, 
              fit: BoxFit.fill, 
              width: width, 
              height: width - 10
            ),
          ),

          SizedBox(height: 10),
          Text(
            '${f.format(item.price)}',        
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,     
              overflow: TextOverflow.ellipsis,   
            ),
          ),

          SizedBox(height: 5),
          Text(
            item.title,
            maxLines: 2,
            style: TextStyle(
              fontSize: 16,
              overflow: TextOverflow.ellipsis,     
            ),
          ),
        ],
      ),
    );
  }
}