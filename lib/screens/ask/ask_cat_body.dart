import 'package:anylearn/dto/ask_dto.dart';
import 'package:anylearn/screens/ask/ask_header.dart';
import 'package:anylearn/screens/ask/ask_list.dart';
import 'package:flutter/material.dart';

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
