import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../dto/v3/listing_dto.dart';

class ListingCardInfo extends StatelessWidget {
  final double width;
  final ListingResultDTO data;
  const ListingCardInfo({Key? key, required this.data, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: Container(
          height: 80,
          width: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: data.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(data.name, maxLines: 2,),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.star, color: Colors.orange, size: 25),
            // Expanded(child: Text('0 | Chưa có đánh giá', style: Theme.of(context).textTheme.bodyLarge))
          ],
        ),
      ),
    );

    // SizedBox(height: 5),
    // Row(children: [
    //   ,
    //   Expanded(child: Text('4.9 | 275 lượt đánh giá', style: Theme.of(context).textTheme.bodyLarge)),
    // ]),
    // SizedBox(height: 5),
    // Row(
    //   children: [
    //     Padding(
    //       padding: EdgeInsets.only(left: 2),
    //       child: Icon(
    //         Icons.discount_outlined,
    //         color: Colors.blue.shade500,
    //         size: 20,
    //       ),
    //     ),
    //     SizedBox(width: 5),
    //     Expanded(
    //       child: Text('Sale 50% !! Voucher 350k !!',
    //           style: TextStyle(
    //             color: Colors.blue.shade700,
    //             fontSize: 20,
    //             overflow: TextOverflow.ellipsis,
    //           )),
    //     )
    //   ],
    // )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
