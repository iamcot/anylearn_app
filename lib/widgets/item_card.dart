import 'package:flutter/material.dart';

import '../customs/custom_cached_image.dart';
import '../dto/item_dto.dart';
import 'price_box.dart';
import 'rating.dart';

class ItemCard extends StatelessWidget {
  final ItemDTO item;
  final double width;

  const ItemCard({required this.item, required this.width});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: width,
            alignment: Alignment.center,
            child: item.image != "" 
                ? ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    // borderRadius: BorderRadius.circular(8.0),
                    child: item.image != "" ? CustomCachedImage(url: item.image) : Icon(Icons.broken_image),
                  )
                : SizedBox(
                    height: width,
                    child: Icon(
                      Icons.school,
                      size: width,
                      color: Colors.grey,
                    ),
                  ),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.all(10),
            child: Text(
              item.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 10),
              height: 18,
              child: PriceBox(
                orgPrice: item.priceOrg,
                price: item.price,
                fontSize: 13,
              )),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: RatingBox(
              score: 5,
              alignment: "left",
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/pdp", arguments: item.id);
                  },
                  child: Text("CHI TIẾT", style: TextStyle(color: Colors.green),),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>((Colors.white)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ))),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
