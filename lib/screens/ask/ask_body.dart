import 'package:anylearn/dto/ask_dto.dart';
import 'package:anylearn/screens/ask/ask_header.dart';
import 'package:anylearn/screens/ask/ask_list.dart';
import 'package:flutter/material.dart';

class AskBody extends StatelessWidget {
  final Map<String, List<AskDTO>> data;

  const AskBody({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(child: Container(child: Image.asset("assets/banners/ask_banner.jpg"))),
        SliverToBoxAdapter(
          child: AskHeader(
            title: "Xem và Học".toUpperCase(),
            route: "/ask/cat",
          ),
        ),
        AskList(data: data["watch"]),
        SliverToBoxAdapter(
          child: AskHeader(
            title: "Đọc và Học".toUpperCase(),
            route: "/ask/cat",
          ),
        ),
        AskList(data: data["read"]),
        SliverToBoxAdapter(
          child: AskHeader(
            title: "Hỏi và Học".toUpperCase(),
            route: "/ask/cat",
          ),
        ),
        AskList(data: data["forum"]),
      ],
    );
  }
}
