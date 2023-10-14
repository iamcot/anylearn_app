import '../../../dto/v3/partner_dto.dart';
import 'items_grid.dart';
import 'items_list.dart';
import 'partner_info.dart';
import 'reviews.dart';
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