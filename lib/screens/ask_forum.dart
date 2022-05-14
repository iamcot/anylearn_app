import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/article/article_blocs.dart';
import '../dto/ask_paging_dto.dart';
import '../dto/const.dart';
import '../main.dart';
import '../themes/role_color.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/fab_home.dart';
import '../widgets/loading_widget.dart';
import '../widgets/search_icon.dart';
import '../widgets/time_ago.dart';
import 'ask_form.dart';

class AskForumScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AskForumScreen();
}

class _AskForumScreen extends State<AskForumScreen> {
  AskPagingDTO? data;
  late ArticleBloc _articleBloc;

  @override
  void didChangeDependencies() {
    _articleBloc = BlocProvider.of<ArticleBloc>(context)..add(AskIndexEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hỏi để học"),
          centerTitle: false,
          actions: [
            SearchIcon(screen: "ask"),
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  if (user.token == "") {
                    Navigator.of(context).pushNamed("/login");
                  } else {
                    final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return AskFormScreen(
                        user: user,
                        askBloc: _articleBloc,
                        askId: 0,
                        type: MyConst.ASK_QUESTION,
                      );
                    }));
                    if (result == true) {
                      _articleBloc = BlocProvider.of<ArticleBloc>(context)..add(AskIndexEvent());
                    }
                  }
                })
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _articleBloc..add(AskIndexEvent());
          },
          child: BlocBuilder(
              bloc: _articleBloc,
              builder: (context, state) {
                if (state is AskIndexSuccessState) {
                  data = state.data;
                }
                return data == null
                    ? LoadingWidget()
                    : Container(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  data!.data[index].title,
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 20),
                                ),
                                leading: data!.data[index].userImage == null
                                    ? SizedBox(height: 0)
                                    : CircleAvatar(
                                        radius: 20,
                                        backgroundColor: roleColor(data!.data[index].userRole),
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundImage: CachedNetworkImageProvider(
                                            data!.data[index].userImage,
                                          ),
                                        ),
                                      ),
                                isThreeLine: true,
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data!.data[index].content,
                                      style: TextStyle(),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: TimeAgo(time: data!.data[index].createdAt))
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).pushNamed("/ask/forum/thread", arguments: data!.data[index].id);
                                },
                                trailing: Icon(Icons.chevron_right),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemCount: data!.data.length),
                      );
              }),
        ),
        floatingActionButton: FloatingActionButtonHome(),
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        bottomNavigationBar: BottomNav(
          route: BottomNav.ASK_INDEX,
          user: user,
        ),
  
    );
  }
}
