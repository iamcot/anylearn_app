import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/article/article_bloc.dart';
import '../dto/article_dto.dart';
import '../dto/const.dart';
import '../main.dart';
import '../widgets/appbar.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/fab_home.dart';
import '../widgets/loading_widget.dart';
import 'ask/ask_cat_body.dart';

class AskCatScreen extends StatefulWidget {
  final type;

  const AskCatScreen({key, this.type}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _AskCatScreen();
}

class _AskCatScreen extends State<AskCatScreen> {
  ArticlePagingDTO? data;

  late ArticleBloc _articleBloc;
  int page = 1;

  @override
  void didChangeDependencies() {
    _articleBloc = BlocProvider.of<ArticleBloc>(context)..add(ArticleTypeEvent(type: widget.type, page: page));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: BaseAppBar(
        title: widget.type == MyConst.ASK_TYPE_READ ? "Đọc để học" .tr(): "Xem để học".tr(), 
        user: user,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            page = 1;
          });
          _articleBloc..add(ArticleTypeEvent(type: widget.type, page: page));
        },
        child: BlocBuilder(
            bloc: _articleBloc,
            builder: (context, state) {
              if (state is ArticleTypeSuccessState) {
                data = state.result;
              }
              return data == null
                  ? LoadingWidget()
                  : AskCatBody(
                      articleBloc: _articleBloc,
                      data: data!,
                      type: widget.type,
                    );
            }),
      ),
      floatingActionButton: FloatingActionButtonHome(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      bottomNavigationBar: BottomNav(
        BottomNav.SOCIAL_INDEX,
      ),
    );
  }
}
