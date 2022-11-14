import 'package:anylearn/dto/profilelikecmt/post_dto.dart';
import 'package:anylearn/widgets/icon_post_comment.dart';
import 'package:anylearn/widgets/text_count_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionPost extends StatefulWidget {
  const ActionPost({Key? key}) : super(key: key);

  @override
  _ActionPostState createState() => _ActionPostState();
}

class _ActionPostState extends State<ActionPost> {
  PostDTO? post;

  int get commentCount => post!.commentCounts;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (post == null &&
            post?.description != null &&
            post!.description!.trim().isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 8),
            child: Text(
              post!.description!,
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
                  padding: const EdgeInsets.only(right: 0, left: 4),
                  // child: Toggle(
                  //   isActivated: isLiked,
                  //   deActivatedChild: Container(
                  //     color: Colors.transparent,
                  //     padding: const EdgeInsets.all(8),
                  //     child: const Icon(CupertinoIcons.heart),
                  //   ),
                  //   activatedChild: Container(
                  //     color: Colors.transparent,
                  //     padding: const EdgeInsets.all(8),
                  //     child: const Icon(
                  //       CupertinoIcons.heart_solid,
                  //       color: Colors.red,
                  //     ),
                  //   ),
                  //   onTrigger: _handleLikePost,
                  //   onTap: (isOn) {
                  //     setState(() {
                  //       likeCount = isOn ? likeCount + 1 : likeCount - 1;
                  //       isLiked = isOn;
                  //     });
                  //   },
                  // ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        post!.isLiked = false;
                        post!.likeCounts -= 1;
                      });
                    },
                    child: post == null
                        ? Container()
                        : post!.isLiked
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
                const IconPostComment(),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              post == null
                  ? Container()
                  : TextCountNumber(
                      number: post!.likeCounts,
                      subText: 'lượt thích',
                    ),
              post == null
                  ? Container()
                  : TextCountNumber(
                      number: post!.commentCounts,
                      subText: 'bình luận',
                    ),
            ],
          ),
        )
      ],
    );
  }
}
