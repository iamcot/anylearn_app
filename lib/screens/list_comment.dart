import 'package:anylearn/blocs/account/account_blocs.dart';
import 'package:anylearn/dto/profilelikecmt/post_dto.dart';
import 'package:anylearn/screens/cmt_item_buble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

class ListComment extends StatefulWidget {
  const ListComment({
    Key? key,
  }) : super(key: key);

  @override
  _ListCommentState createState() => _ListCommentState();
}

class _ListCommentState extends State<ListComment> {
  late AccountBloc _accountBloc;
  int userId = 0;
  PostDTO? postId;

  @override
  void didChangeDependencies() {
    _accountBloc = BlocProvider.of<AccountBloc>(context);
    try {
      userId =
          int.parse((ModalRoute.of(context)!.settings.arguments.toString()));
    } catch (e) {}
    if (userId == 0) {
      _accountBloc..add(AccPostContentEvent(id: userId));
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      bloc: _accountBloc,
      builder: (context, state) {
        if (state is AccPostContentSuccessState) {
          if (state is AccPostContentLoadingState) {
            postId = state.data.comments!.isEmpty as PostDTO?;
            return Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(top: 12),
              child: const Center(
                child: Text('No comment'),
              ),
            );
          }
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              final postId = state.data.comments![index] as List<PostDTO>?;

              return Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: CommentItemBubble(
                        cmt: postId![index],
                        onReact: (type, isUnReact) {
                          // if(!isUnReact){
                          //   commentBloc!.react(comment.id!, type);
                          // }
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: state.data.comments!.length ?? 0,
          );
        }
        if (state is AccPostContentFailState) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
        return const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
