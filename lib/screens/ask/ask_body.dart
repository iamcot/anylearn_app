import 'package:anylearn/dto/const.dart';
import 'package:anylearn/screens/ask/ask_forum_list.dart';
import 'package:flutter/material.dart';

import '../../dto/article_dto.dart';
import 'ask_header.dart';
import 'ask_list.dart';

class AskBody extends StatelessWidget {
  final ArticleHomeDTO data;

  const AskBody({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(child: Container(child: Image.asset("assets/banners/ask_banner.jpg"))),
        SliverToBoxAdapter(
          child: AskHeader(
            title: "Hỏi và Học".toUpperCase(),
            route: "/ask/forum",
          ),
        ),
        AskForumList(data: data.asks),
        SliverToBoxAdapter(
          child: AskHeader(
            title: "Xem để Học".toUpperCase(),
            type: MyConst.ASK_TYPE_VIDEO,
          ),
        ),
        AskList(data: data.videos),
        SliverToBoxAdapter(
          child: AskHeader(
            title: "Đọc để Học".toUpperCase(),
            type: MyConst.ASK_TYPE_READ,
          ),
        ),
        AskList(data: data.reads),
      ],
    );
  }
}
