import 'package:flutter/material.dart';

import '../../dto/ask_dto.dart';
import 'ask_list.dart';

class AskCatBody extends StatelessWidget {
  final List<AskDTO> data;
  const AskCatBody({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(child: Container(child: Image.asset("assets/banners/ask_banner.jpg"))),
        AskList(data: data),
      ],
    );
  }
}
