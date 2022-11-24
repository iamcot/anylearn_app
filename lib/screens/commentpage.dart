import '../dto/const.dart';
import '../main.dart';
import 'list_comment.dart';
import '../widgets/textFieldcomment.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import '../blocs/account/account_bloc.dart';
import '../blocs/account/account_blocs.dart';
import '../dto/profilelikecmt/post_dto.dart';
import '../widgets/action_post.dart';
import '../widgets/item_row.dart';

class CommentPage extends StatefulWidget {
  PostDTO post;

  CommentPage({Key? key, required this.post}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late AccountBloc _accountBloc;
  final TextEditingController commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool needScroll = false;

  void didChangeDependencies() {
    super.didChangeDependencies();
    _accountBloc = BlocProvider.of<AccountBloc>(context);
    _accountBloc..add(AccPostContentEvent(id: widget.post.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      bloc: _accountBloc,
      listener: (context, state) {
        if (state is AccPostContentFailState) {
          toast(state.error.toString());
        }
        if (state is ActionUserSuccessState) {
          _accountBloc..add(AccPostContentEvent(id: widget.post.id));
          setState(() {
            needScroll = true;
          });
        }
      },
      child: BlocBuilder<AccountBloc, AccountState>(
          bloc: _accountBloc,
          builder: (context, state) {
            if (state is AccPostContentSuccessState) {
              widget.post = state.data;
            }

            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                title:
                    Text("Bình Luận ", style: TextStyle(color: Colors.black)),
                backgroundColor: Colors.white,
              ),
              body: Container(
                child: CommentBox(
                  userImage: CommentBox.commentImageParser(
                      imageURLorPath: user.image != ""
                          ? user.image
                          : "assets/icons/cirle.png"),
                  child: scrollview(),
                  labelText: 'Write a comment...',
                  errorText: 'Comment cannot be blank',
                  withBorder: false,
                  sendButtonMethod: () {
                    _accountBloc
                      ..add(ActionUserEvent(
                          content: commentController.text,
                          token: user.token,
                          type: MyConst.TYPE_ACTION_COMMENT,
                          id: widget.post.id));
                    commentController.clear();
                    FocusScope.of(context).unfocus();
                  },
                  formKey: formKey,
                  commentController: commentController,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  sendWidget:
                      Icon(Icons.send_sharp, size: 30, color: Colors.grey),
                ),
              ),
            );
          }),
    );
  }

  CustomScrollView scrollview() {
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 0, 8),
                child: widget.post == null
                    ? Container()
                    : ItemRow(
                        post: widget.post,
                        // avatarUrl: user.image,
                        // title: user.name,
                        subtitle: widget.post.displayTimePostCreated,
                        rightWidget: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_horiz),
                        ),
                      ),
              ),
              titleSection(),
              imageSection(),
              ActionPost(
                post: widget.post,
              ),
              const Divider(thickness: 1),
              ListComment(post: widget.post),
            ],
          ),
        ),
      ],
    );
  }

  Widget imageSection() {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: CachedNetworkImage(
        imageUrl: widget.post.images.toString(),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget titleSection() {
    return widget.post.title != null && widget.post.title != ""
        ? Container(
            padding: EdgeInsets.only(bottom: 5, left: 10, right: 10),
            alignment: Alignment.bottomLeft / 1.2,
            child: Text(
              widget.post.title == null ? "N/A" : widget.post.title.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          )
        : SizedBox();
  }
}
