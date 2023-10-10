import 'package:anylearn/dto/v3/listing_dto.dart';
import 'package:anylearn/screens/v3/listing/card_info.dart';
import 'package:anylearn/screens/v3/listing/card_item.dart';
import 'package:flutter/material.dart';

class ListingCard extends StatelessWidget {
  final ListingResultDTO data;
  const ListingCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),  
      child: Column(
        children: [   
          ListingCardInfo(data: data, width: 105.0),
          SizedBox(height: 20),
          ListingCardItem(data: data, width: 105.0),         
        ],
      ),
    );
  }
}