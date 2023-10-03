import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/article/article_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../dto/ask_dto.dart';
import '../dto/ask_thread_dto.dart';
import '../dto/const.dart';
import '../main.dart';
import '../themes/role_color.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/fab_home.dart';
import '../widgets/gradient_button.dart';
import '../widgets/loading_widget.dart';
import '../widgets/time_ago.dart';
import 'ask_form.dart';

class AskForumThreadScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AskForumThreadScreen();
}

class _AskForumThreadScreen extends State<AskForumThreadScreen> {
  AskThreadDTO? data;
  late ArticleBloc _articleBloc;
  late int askId;
  late AuthBloc _authBloc;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    askId = int.parse(args.toString());
    _articleBloc = BlocProvider.of<ArticleBloc>(context)..add(AskThreadEvent(askId: askId, token: user.token));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Hỏi để học").tr(),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _articleBloc..add(AskThreadEvent(askId: askId, token: user.token));
        },
        child: BlocListener<ArticleBloc, ArticleState>(
          bloc: _articleBloc,
          listener: (context, state) {
            if (state is AskVoteSuccessState) {
              _articleBloc..add(AskThreadEvent(askId: askId, token: user.token));
            }
            if (state is AskSelectSuccessState) {
              _articleBloc..add(AskThreadEvent(askId: askId, token: user.token));
            }
          },
          child: BlocBuilder(
              bloc: _articleBloc,
              builder: (context, state) {
                if (state is AskThreadSuccessState) {
                  data = state.data;
                }
                return data == null
                    ? LoadingWidget()
                    : Container(
                        child: ListView(
                            children: [_questionBox(data!.question), _answerInput()] + _answersBox(data!.answers)));
              }),
        ),
      ),
      bottomNavigationBar: BottomNav(
        BottomNav.SOCIAL_INDEX,
      ),
    );
  }

  Widget _questionBox(AskDTO question) {
    return Container(
        // padding: EdgeInsets.only(top: 10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: Container(
              // margin: EdgeInsets.only(right: 8),
              // width: 40.0,
              // height: 40.0,
              child: question.userImage == null
                  ? Icon(Icons.account_box)
                  : CircleAvatar(
                      radius: 22,
                      backgroundColor: roleColor(question.userRole),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: CachedNetworkImageProvider(
                          question.userImage,
                        ),
                      ))),
          title: Text(
            question.username,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Đã hỏi ", style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)).tr(),
              TimeAgo(time: question.createdAt),
            ],
          ),
        ),
      ),
      Row(children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Text(question.title, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ]),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          question.content,
        ),
      ),
      // Divider(),
    ]));
  }

  List<Widget> _answersBox(List<AskDTO> answers) {
    List<Widget> list = [];
    list.add(Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border(
            // bottom: BorderSide(color: Colors.grey, width: 1.0),
            // top: BorderSide(color: Colors.grey[400], width: 1.0),
            ),
      ),
      padding: const EdgeInsets.all(10.0),
      child: data!.answers.length > 0
          ? Text(
              "Có ${data!.answers.length} câu trả lời",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ).tr()
          : Text("Chưa có câu trả lời.").tr(),
    ));
    answers.forEach((ans) {
      list.add(
        Container(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: Container(
                        // margin: EdgeInsets.only(right: 8),
                        // width: 40.0,
                        // height: 40.0,
                        child: ans.userImage == null
                            ? Icon(Icons.account_box)
                            : CircleAvatar(
                                radius: 20,
                                backgroundColor: roleColor(ans.userRole),
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundImage: CachedNetworkImageProvider(
                                    ans.userImage,
                                  ),
                                ),
                              )),
                    title: Text(
                      ans.username,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Đã trả lời ", style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)).tr(),
                        TimeAgo(time: ans.createdAt),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0),
                    child: Text(
                      ans.content,
                    ),
                  ),
                  Container(
                    child: Row(children: [
                      Expanded(
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(0),
                          ),
                          icon: Icon(
                            Icons.thumb_up,
                            color: ans.myVote == MyConst.ASK_VOTE_LIKE ? Colors.blue : Colors.grey[600],
                          ),
                          onPressed: () async {
                            if (user.token == "") {
                              Navigator.of(context).pushNamed("/login");
                            } else {
                              if (ans.myVote != MyConst.ASK_VOTE_LIKE) {
                                _articleBloc
                                  ..add(AskVoteEvent(askId: ans.id, type: MyConst.ASK_VOTE_LIKE, token: user.token));
                              }
                            }
                          },
                          label: Text(ans.like.toString()),
                        ),
                      ),
                      Expanded(
                        child: TextButton.icon(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.all(0),
                            ),
                            onPressed: () async {
                              if (user.token == "") {
                                Navigator.of(context).pushNamed("/login");
                              } else {
                                if (ans.myVote != MyConst.ASK_VOTE_DISLIKE) {
                                  _articleBloc
                                    ..add(
                                        AskVoteEvent(askId: ans.id, type: MyConst.ASK_VOTE_DISLIKE, token: user.token));
                                }
                              }
                            },
                            label: Text(ans.unlike.toString()),
                            icon: Icon(
                              Icons.thumb_down,
                              color: ans.myVote == MyConst.ASK_VOTE_DISLIKE ? Colors.red : Colors.grey[600],
                            )),
                      ),
                      Expanded(
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(0),
                          ),
                          onPressed: () async {
                            if (user.token == "") {
                              Navigator.of(context).pushNamed("/login");
                            } else {
                              bool result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                return AskFormScreen(
                                  askBloc: _articleBloc,
                                  askId: ans.id,
                                  type: MyConst.ASK_COMMENT,
                                );
                              }));
                              if (result) {
                                _articleBloc = BlocProvider.of<ArticleBloc>(context)
                                  ..add(AskThreadEvent(askId: askId, token: user.token));
                              }
                            }
                          },
                          label: Text(ans.comments.length.toString()),
                          icon: Icon(Icons.insert_comment, color: Colors.grey[600]),
                        ),
                      ),
                      (data != null && data!.question.userId == user.id)
                          ? Expanded(
                              child: TextButton(
                                onPressed: () async {
                                  if (user.token == "") {
                                    Navigator.of(context).pushNamed("/login");
                                  } else {
                                    _articleBloc..add(AskSelectEvent(askId: ans.id, token: user.token));
                                  }
                                },
                                child: ans.selectedAnswer
                                    ? Icon(Icons.check_circle_outline, color: Colors.green)
                                    : Text(
                                        "Chọn",
                                        style: TextStyle(color: Colors.grey[600]),
                                      ).tr(),
                              ),
                            )
                          : SizedBox(
                              height: 0,
                            ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      if (ans.comments.length > 0) {
        list.add(
          Container(
            // color: Colors.grey[200],
            padding: EdgeInsets.only(left: 50.0, right: 10.0),
            // child: Expanded(
            child: Column(
              children: ans.comments.map<Widget>((comment) {
                return Card(
                  child: Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        border: Border(bottom: BorderSide(color: (Colors.grey[200])!)),
                      ),
                      child: ListTile(
                        leading: Container(
                            // margin: EdgeInsets.only(right: 8),
                            // width: 40.0,
                            // height: 40.0,
                            child: comment.userImage == null
                                ? Icon(Icons.account_box)
                                : CircleAvatar(
                                    radius: 18,
                                    backgroundColor: roleColor(comment.userRole),
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundImage: CachedNetworkImageProvider(
                                        comment.userImage,
                                      ),
                                    ),
                                  )),
                        contentPadding: EdgeInsets.all(0),
                        isThreeLine: false,
                        title: Text(comment.username),
                        subtitle: Text(comment.content),
                      )),
                );
              }).toList(),
            ),
            // ),
          ),
        );
      }
    });
    return list;
  }

  Widget _answerInput() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: GradientButton(
              title: "Trả lời".tr(),
              // height: 48.0,
              function: () async {
                if (user.token == "") {
                  Navigator.of(context).pushNamed("/login");
                } else {
                  bool result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return AskFormScreen(
                      askBloc: _articleBloc,
                      askId: data!.question.id,
                      type: MyConst.ASK_ANSWER,
                    );
                  }));
                  if (result) {
                    _articleBloc = BlocProvider.of<ArticleBloc>(context)
                      ..add(AskThreadEvent(askId: askId, token: user.token));
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
