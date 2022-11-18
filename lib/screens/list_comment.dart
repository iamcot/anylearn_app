import 'package:anylearn/blocs/account/account_blocs.dart';
import 'package:anylearn/dto/profilelikecmt/post_dto.dart';
import 'package:anylearn/screens/cmt_item_buble.dart';
import 'package:anylearn/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

class ListComment extends StatefulWidget {
  PostDTO? post;

  ListComment({Key? key, required this.post}) : super(key: key);

  @override
  _ListCommentState createState() => _ListCommentState();
}

class _ListCommentState extends State<ListComment> {
  late AccountBloc _accountBloc;

  @override
  void didChangeDependencies() {
    _accountBloc = BlocProvider.of<AccountBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      bloc: _accountBloc,
      listener: (context, state) {
        if (state is AccPostContentFailState) {
          toast(state.error.toString());
        }
      },
      child: BlocBuilder<AccountBloc, AccountState>(
          bloc: _accountBloc,
          builder: (context, state) {
            if (state is AccPostContentSuccessState) {
              widget.post = state.data;
              if (state is AccPostContentLoadingState) {
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
                  widget.post = state.data;

                  return Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: CommentItemBubble(
                            post: widget.post!.comments![index],
                            onReact: (type, isUnReact) {},
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: state.data.comments!.length ?? 0,
              );
            }
            return LoadingWidget();
          }),
    );
    // return BlocBuilder<AccountBloc, AccountState>(
    //   bloc: _accountBloc,
    //   builder: (context, state) {
    //     if (state is AccPostContentSuccessState) {
    //       if (state is AccPostContentLoadingState) {
    //         return Container(
    //           color: Colors.transparent,
    //           padding: const EdgeInsets.only(top: 12),
    //           child: const Center(
    //             child: Text('No comment'),
    //           ),
    //         );
    //       }
    //       return ListView.builder(
    //         physics: const NeverScrollableScrollPhysics(),
    //         shrinkWrap: true,
    //         padding: const EdgeInsets.all(0),
    //         itemBuilder: (context, index) {
    //           widget.post = state.data;

    //           return Container(
    //             color: Colors.transparent,
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.all(0),
    //                   child: CommentItemBubble(
    //                     post: widget.post!.comments![index],
    //                     onReact: (type, isUnReact) {},
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           );
    //         },
    //         itemCount: state.data.comments!.length ?? 0,
    //       );
    //     }
    //     if (state is AccPostContentFailState) {
    //       return const Center(
    //         child: Text('Something went wrong'),
    //       );
    //     }
    //     return const Padding(
    //       padding: EdgeInsets.only(top: 10.0),
    //       child: Center(child: CircularProgressIndicator()),
    //     );
    //   },
    // );
  }
}
