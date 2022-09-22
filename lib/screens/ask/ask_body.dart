import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../blocs/article/article_blocs.dart';
import '../../dto/article_dto.dart';
import '../../dto/const.dart';
import '../../dto/user_dto.dart';
import '../ask_form.dart';
import 'ask_forum_list.dart';
import 'ask_header.dart';
import 'ask_list.dart';

class AskBody extends StatelessWidget {
  final ArticleHomeDTO data;
  final UserDTO user;
  final ArticleBloc articleBloc;

  const AskBody({key, required this.data, required this.user, required this.articleBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
            Text('title').tr(),

        SliverToBoxAdapter(child: Container(child: Image.asset("assets/banners/ask_banner.jpg"))),
        SliverToBoxAdapter(
          child: Container(
            height: 80,
            padding: EdgeInsets.all(15),
            child: TextFormField(
              onTap: () async {
                if (user.token == "") {
                  Navigator.of(context).pushNamed("/login");
                } else {
                  final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return AskFormScreen(
                      askBloc: articleBloc,
                      askId: 0,
                      type: MyConst.ASK_QUESTION,
                    );
                  }));
                  if (result == true) {
                    articleBloc..add(AskIndexEvent());
                  }
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: (Colors.blue[200])!, width: 3),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                hintText: "Bạn đang muốn hỏi điều gì ?",
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: Icon(Icons.question_answer),
                // onPressed: () {
                //   showSearch(context: context, delegate: CustomSearchDelegate(screen: ""), query: searchController.text);
                // },
                // ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: AskHeader(
            title: "Hỏi để Học".toUpperCase(),
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
