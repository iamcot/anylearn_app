import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../blocs/article/article_bloc.dart';
import '../../blocs/article/article_blocs.dart';
import '../../dto/article_dto.dart';
import 'ask_list.dart';

class AskCatBody extends StatelessWidget {
  final ArticlePagingDTO data;
  final type;
  final ArticleBloc articleBloc;
  const AskCatBody({key, required this.data,required this.articleBloc, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[

        SliverToBoxAdapter(child: Container(child: Image.asset("assets/banners/ask_banner.jpg"))),
        AskList(data: data.data),
        SliverToBoxAdapter(
          child: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              data.currentPage > 1
                  ? TextButton.icon(
                      onPressed: () async {
                        articleBloc..add(ArticleTypeEvent(type: type, page: (data.currentPage - 1)));
                      },
                      icon: Icon(Icons.chevron_left),
                      label: Text("TRANG TRƯỚC", style: TextStyle(color: Colors.blue),).tr(),
                    )
                  : SizedBox(height: 0),
              data.lastPage > data.currentPage
                  ? TextButton.icon(
                      onPressed: () async {
                        articleBloc..add(ArticleTypeEvent(type: type, page: (data.currentPage + 1)));
                      },
                      icon: Icon(Icons.chevron_right),
                      label: Text("TRANG SAU", style: TextStyle(color: Colors.blue),).tr(),
                    )
                  : SizedBox(height: 0),
            ],
          )),
        )
      ],
    );
  }
}
