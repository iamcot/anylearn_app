import '../../../dto/v3/subtype_dto.dart';
import '../home/classes.dart';
import 'cat_list.dart';
import 'partner_list.dart';
import 'package:flutter/material.dart';

import '../../../widgets/items_list_2.dart';
import '../../../widgets/items_list_3.dart';
import '../home/vouchers.dart';


class SubtypeBody extends StatefulWidget {
  final String subtype;
  final SubtypeDTO data;

  const SubtypeBody({Key? key, required this.subtype, required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SubtypeBody();
}

class _SubtypeBody extends State<SubtypeBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SubtypeCatList(subtype: widget.subtype, categories: widget.data.categories),
        ItemsList3(hotItems: widget.data.j4u),
        ItemsList2(hotItems: widget.data.repurchaseds),
        HomeVoucher(vouchers: widget.data.vouchers),
        PartnerList(partners: widget.data.partners),
        HomeClasses(blocks: widget.data.partnerItems),
        HomeClasses(blocks: widget.data.categoryItems),
      ],
    );
  }
}
