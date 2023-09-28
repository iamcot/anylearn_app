import 'package:anylearn/dto/v3/listing_dto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListingCardInfo extends StatelessWidget {
  final double width;
  final ListingResultDTO data;
  const ListingCardInfo({Key? key, required this.data, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ 
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child:CachedNetworkImage(imageUrl: data.image, fit: BoxFit.cover, width: width, height: width - 10)
        ),

        SizedBox(width: 15),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Column(children: [
              Row(children: [
                Expanded(
                  child: Text(
                    data.name,
                    style: TextStyle(
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,                              
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,                
                    ),
                  ),
                ),
              ]),

              SizedBox(height: 5),
              Row(children: [
                Icon(Icons.star_outline, color: Colors.blue.shade500, size: 23),
                Expanded(
                  child: Text(
                    '4.9 | 275 lượt đánh giá',
                    style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
                  ),
                ),
              ]),

                SizedBox(height: 5),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Icon(
                      Icons.discount_outlined,
                      color: Colors.blue.shade500,
                      size: 18,
                    ),
                  ),

                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    'Sale 50% !! Voucher 350k !!', 
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 18,                         
                      overflow: TextOverflow.ellipsis,
                    )
                  ),
                )],
              )],
            ),
          ),
        ),
      ],
    );
  }
}