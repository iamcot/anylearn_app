import 'package:anylearn/widgets/icon_post_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import '../blocs/account/account_blocs.dart';
import '../dto/const.dart';
import '../dto/profilelikecmt/post_dto.dart';
import '../main.dart';
import 'icon_post_comment.dart';
import 'text_count_number.dart';

class ActionPost extends StatefulWidget {
  PostDTO post;

  ActionPost({Key? key, required this.post}) : super(key: key);

  @override
  _ActionPostState createState() => _ActionPostState();
}

class _ActionPostState extends State<ActionPost>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);

  int get commentCount => widget.post.commentCounts ?? 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.post == null &&
            widget.post.description != null &&
            widget.post.description!.trim().isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 8),
            child: Text(
              widget.post.description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: GestureDetector(
                    onTap: () {
                      // if (widget.post.isLiked) {
                      //   setState(() {
                      //     widget.post.isLiked = false;
                      //     widget.post.likeCounts -= 1;
                      //   });
                      //   _accountBloc
                      //     ..add(ActionUserEvent(
                      //         content: "",
                      //         token: user.token,
                      //         type: MyConst.TYPE_ACTION_DISLIKE,
                      //         id: widget.post.id));
                      // } else {
                      //   setState(() {
                      //     widget.post.isLiked = true;
                      //     widget.post.likeCounts += 1;
                      //   });
                      //   _accountBloc
                      //     ..add(ActionUserEvent(
                      //         content: "",
                      //         token: user.token,
                      //         type: MyConst.TYPE_ACTION_DISLIKE,
                      //         id: widget.post.id));
                      //   _controller
                      //       .reverse()
                      //       .then((value) => _controller.forward());
                      // }
                    },
                    child: widget.post == null
                        ? Container()
                        : widget.post.isLiked
                            ? Container(
                                color: Colors.transparent,
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  CupertinoIcons.heart_solid,
                                  color: Colors.red,
                                ),
                              )
                            : Container(
                                color: Colors.grey,
                                padding: const EdgeInsets.all(8),
                                child: const Icon(CupertinoIcons.heart),
                              ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                IconPostComment(),
                SizedBox(
                  width: 30,
                ),
                IconPostShare(),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              widget.post == null
                  ? Container()
                  : TextCountNumber(
                      number: widget.post.likeCounts,
                      subText: 'lượt thích',
                    ),
              widget.post == null
                  ? Container()
                  : TextCountNumber(
                      number: widget.post.comments!.length,
                      subText: 'bình luận',
                    ),
              widget.post == null
                  ? Container()
                  : TextCountNumber(
                      number: widget.post.shareCounts, subText: 'chia sẻ'),
            ],
          ),
        )
      ],
    );
  }
}
