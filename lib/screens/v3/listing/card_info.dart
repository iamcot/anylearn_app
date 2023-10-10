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
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
            imageUrl: data.image, 
            fit: BoxFit.cover, 
            width: width, 
            height: width - 5,
          ),
        ),
    
        SizedBox(width: 15),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Text(data.name, style: Theme.of(context).textTheme.titleMedium)),
                  ]
                ),
      
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.star_outline, color: Colors.blue.shade500, size: 25),
                    Expanded(child: Text('4.9 | 275 lượt đánh giá', style: Theme.of(context).textTheme.bodyLarge)),
                  ]
                ),
    
                SizedBox(height: 5),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 2),
                      child: Icon(
                        Icons.discount_outlined,
                        color: Colors.blue.shade500,
                        size: 20,
                      ),
                    ),
    
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'Sale 50% !! Voucher 350k !!', 
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontSize: 20,                         
                          overflow: TextOverflow.ellipsis,
                        )
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}