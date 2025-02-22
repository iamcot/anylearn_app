import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/subtype/subtype_bloc.dart';
import '../../../dto/user_dto.dart';
import '../../../dto/v3/subtype_dto.dart';
import '../../../main.dart';
import '../../../models/page_repo.dart';
import '../../../widgets/bottom_nav.dart';
import '../../loading.dart';
import '../home/search_box.dart';
import '../map/screen.dart';
import 'body.dart';

class SubtypeScreen extends StatefulWidget {
  final dynamic subtype;
  const SubtypeScreen({Key? key, required this.subtype}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SubtypeScreen();
}

class _SubtypeScreen extends State<SubtypeScreen> {
  final searchController = TextEditingController();
  SubtypeDTO? data;

  late SubtypeBloc _bloc;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    _bloc = SubtypeBloc(pageRepository: pageRepo);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubtypeBloc, SubtypeState>(
      bloc: _bloc..add(LoadSubtypePageEvent(category: widget.subtype['type'])),
      builder: (context, state) {
        if (state is SubtypeSuccessState) {
          data = state.data;
        }

        if (state is SubtypeFailState) {
          return Scaffold(
            body: Container(alignment: Alignment.center, child: Text(state.error.toString())),
          );
        }

        return data == null
            ? LoadingScreen()
            : Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(120.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.blue,
                          Colors.white, //@TODO change to white later
                        ],
                        stops: [0.7, 0.3],
                      ),
                    ),
                    child: Column(
                      children: [
                        AppBar(
                          title: Text(widget.subtype["title"]),
                          titleSpacing: 0,
                          centerTitle: false,
                          elevation: 0,
                          actions: [
                            // Container(
                            //   margin: EdgeInsets.only(right: 10),
                            //   child: TextButton.icon(
                            //     onPressed: () {
                            //       Navigator.of(context).push(
                            //         MaterialPageRoute(builder: (context) => MapScreen(subtype: widget.subtype))
                            //       );
                            //     },
                            //     icon: Icon(
                            //       Icons.map_outlined,
                            //       color: Colors.white,
                            //     ),
                            //     label: Text(
                            //       "Bản đồ",
                            //       style: TextStyle(color: Colors.white),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                        Container(
                          // height: 100.0,
                          margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  height: 50.0,
                                  child: SearchBox(user: user),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                body: RefreshIndicator(
                  child: SubtypeBody(subtype: widget.subtype['type'], data: data!),
                  onRefresh: _reloadPage,
                ),
                bottomNavigationBar: BottomNav(BottomNav.HOME_INDEX),
              );
      },
    );
  }

  Future<void> _reloadPage() async {
    _bloc..add(LoadSubtypePageEvent(category: widget.subtype['type']));
  }
}
