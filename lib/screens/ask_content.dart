import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/article/article_bloc.dart';
import '../blocs/article/article_blocs.dart';
import '../dto/article_dto.dart';
import '../dto/const.dart';
import '../widgets/loading_widget.dart';
import 'ask/content_read.dart';
import 'ask/content_video.dart';

class AskArticleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AskArticleScreen();
}

class _AskArticleScreen extends State<AskArticleScreen> {
  ArticleDTO data;
  ArticleBloc _articleBloc;
  int id;

  @override
  void didChangeDependencies() {
    id = ModalRoute.of(context).settings.arguments;
    print(id);
    _articleBloc = BlocProvider.of<ArticleBloc>(context)..add(ArticlePageEvent(id: id));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double imageHeight = width - 80;
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          _articleBloc..add(ArticlePageEvent(id: id));
        },
        child: BlocBuilder(
            bloc: _articleBloc,
            builder: (context, state) {
              if (state is ArticlePageSuccessState) {
                data = state.result;
                if (data.type == MyConst.ASK_TYPE_VIDEO && data.video != null) {}
              }
              return data == null
                  ? LoadingWidget()
                  : Container(
                      padding: EdgeInsets.all(15),
                      child: data.type == MyConst.ASK_TYPE_VIDEO ? ContentVideo(data: data) : ContentRead(data: data),
                    );
            }),
      ),
    );
  }
}
