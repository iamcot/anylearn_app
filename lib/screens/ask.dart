import 'package:anylearn/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/article/article_bloc.dart';
import '../blocs/article/article_blocs.dart';
import '../dto/article_dto.dart';
import '../widgets/appbar.dart';
import '../widgets/bottom_nav.dart';
import 'ask/ask_body.dart';

class AskScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AskScreen();
}

class _AskScreen extends State<AskScreen> {
  ArticleHomeDTO data;
  ArticleBloc _articleBloc;

  @override
  void didChangeDependencies() {
    _articleBloc = BlocProvider.of<ArticleBloc>(context)..add(ArticleIndexEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Học & Hỏi",
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _articleBloc..add(ArticleIndexEvent());
        },
        child: BlocBuilder(
            bloc: _articleBloc,
            builder: (context, state) {
              if (state is ArticleIndexSuccessState) {
                data = state.result;
              }
              return data == null
                  ? LoadingWidget()
                  : AskBody(
                      data: data,
                    );
            }),
      ),
      bottomNavigationBar: BottomNav(
        index: BottomNav.ASK_INDEX,
      ),
    );
  }
}
