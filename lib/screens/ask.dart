import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/article/article_bloc.dart';
import '../blocs/article/article_blocs.dart';
import '../blocs/auth/auth_blocs.dart';
import '../dto/article_dto.dart';
import '../main.dart';
import '../widgets/appbar.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/fab_home.dart';
import '../widgets/loading_widget.dart';
import 'ask/ask_body.dart';

class AskScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AskScreen();
}

class _AskScreen extends State<AskScreen> {
  ArticleHomeDTO? data;
  late AuthBloc _authBloc;
  late ArticleBloc _articleBloc;

  @override
  void didChangeDependencies() {
    _articleBloc = BlocProvider.of<ArticleBloc>(context)..add(ArticleIndexEvent());
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Học & Hỏi",
        user: user,
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
                      data: data!,
                      user: user,
                      articleBloc: _articleBloc,
                    );
            }),
      ),
      floatingActionButton: FloatingActionButtonHome(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      bottomNavigationBar: BottomNav(
        route: BottomNav.ASK_INDEX,
      ),
    );
  }
}
