import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

import '../blocs/home/home_blocs.dart';
import '../models/page_repo.dart';
import 'loading.dart';

class GuideScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GuideScreen();
}

class _GuideScreen extends State<GuideScreen> {
  HomeBloc _homeBloc;

  @override
  void didChangeDependencies() {
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    _homeBloc = HomeBloc(pageRepository: pageRepo);
    final path = ModalRoute.of(context).settings.arguments;
    if (path == null) {
      Navigator.of(context).pop();
    }
    _homeBloc..add(LoadGuideEvent(path: path));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 10;
    return BlocProvider<HomeBloc>(
      create: (context) => _homeBloc,
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is GuideFailState) {
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder(
            bloc: _homeBloc,
            builder: (context, state) {
              if (state is GuideLoadSuccessState) {
                return Scaffold(
                  appBar: AppBar(),
                  body: ListView(children: [
                    Container(
                      padding: EdgeInsets.only(left:15, right: 15.0, bottom: 15),
                      child: Html(
                        data: state.doc.content,
                        shrinkWrap: true,
                      ),
                    ),
                    Divider(),
                    Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(right: 15.0, bottom: 15),
                      child: Text(
                        " Cập nhật cuối: " + DateFormat("hh:mm dd/MM/yyyy").format(state.doc.lastUpdate),
                        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10.0),
                      ),
                    ),
                  ]),
                );
              }
              return LoadingScreen();
            }),
      ),
    );
  }
}
