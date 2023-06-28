import 'package:anylearn/dto/v3/subtype_dto.dart';
import 'package:anylearn/screens/v3/subtype/cat_list.dart';
import 'package:flutter/material.dart';

import '../../../blocs/home/home_bloc.dart';
import '../../../dto/v3/home_dto.dart';
import '../../../widgets/items_list_2.dart';
import '../../../widgets/items_list_3.dart';
import '../home/vouchers.dart';


class SubtypeBody extends StatefulWidget {
  const SubtypeBody({Key? key, required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SubtypeBody();
  final SubtypeDTO data;
}

class _SubtypeBody extends State<SubtypeBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SubtypeCatList(categories: widget.data.categories),
        ItemsList3(hotItems: widget.data.j4u),
        ItemsList2(hotItems: widget.data.repurchaseds),
        HomeVoucher(vouchers: widget.data.vouchers),
        ItemsList3(hotItems: widget.data.recommendations),
      ],
    );
  }
}
