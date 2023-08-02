import 'package:anylearn/dto/v3/partner_dto.dart';
import 'package:anylearn/screens/v3/partner/items_grid.dart';
import 'package:anylearn/screens/v3/partner/items_list.dart';
import 'package:anylearn/screens/v3/partner/partner_info.dart';
import 'package:anylearn/screens/v3/partner/reviews.dart';
import 'package:flutter/material.dart';

class PartnerBody extends StatelessWidget {
  final PartnerDTO? data;
  const PartnerBody({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      PartnerInfo(
        partner: data?.partner, 
        sumRating: data?.sumRating.toDouble(), 
        sumReviews: data?.sumReviews
      ),
      ItemsGrid(items: data?.hotItems),
      Reviews(reviews: data?.reviews),
      ItemsList(items: data?.normalItems),
    ]);
  }
}