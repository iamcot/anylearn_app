import 'package:anylearn/screens/list_comment.dart';
import 'package:anylearn/widgets/textFieldcomment.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import '../blocs/account/account_bloc.dart';
import '../blocs/account/account_blocs.dart';
import '../dto/profilelikecmt/post_dto.dart';
import '../widgets/action_post.dart';
import '../widgets/item_row.dart';

class CommentPage extends StatefulWidget {
  final PostDTO postId;

  const CommentPage({Key? key, required this.postId}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late AccountBloc _accountBloc;
  TextEditingController? controller;

  void didChangeDependencies() {
    super.didChangeDependencies();
    _accountBloc = BlocProvider.of<AccountBloc>(context);
    _accountBloc..add(AccPostContentEvent(id: widget.postId.id));
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
              widget.postId.id = state.data.id;
            }
            return Scaffold(
              body: Stack(
                children: [
                  CustomScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    slivers: <Widget>[
                      SliverAppBar(
                        // title: Text(
                        //   "Post Details Page",
                        //   style: TextStyle(color: Colors.black),
                        // ),
                        snap: true,
                        floating: true,
                        elevation: 1,
                        forceElevated: true,
                        backgroundColor: Colors.white,
                        leading: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            )),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(12, 12, 0, 8),
                            //   child: widget.postId == null
                            //       ? Container()
                            //       : ItemRow(
                            //           avatarUrl: widget.postId.user!.image,
                            //           title: widget.postId.user!.name,
                            //           subtitle:
                            //               widget.postId.displayTimePostCreated,
                            //           rightWidget: IconButton(
                            //             onPressed: () {},
                            //             icon: const Icon(Icons.more_horiz),
                            //           ),
                            //         ),
                            // ),
                            ActionPost(
                              post: widget.postId,
                            ),
                            // const Divider(thickness: 1),
                            ListComment(postId: widget.postId),
                            SizedBox(
                              height: 550,
                            ),
                            TextFieldComment(),
                            // TextField(
                            //   controller: controller,
                            //   maxLines: 3,
                            //   decoration: new InputDecoration(
                            //       hintText: 'Write a Comment',
                            //       hintStyle: new TextStyle(
                            //         color: Colors.grey,
                            //       ),
                            //       prefixIcon: InkWell(
                            //         child: Icon(Icons.camera_alt),
                            //         onTap: () {
                            //         },
                            //       ),
                            //       suffixIcon: InkWell(
                            //         child: Icon(
                            //           Icons.send,
                            //         ),
                            //         onTap: () {

                            //         },
                            //       )),
                            //   style: new TextStyle(
                            //     color: Colors.black,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
