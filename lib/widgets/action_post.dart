import 'package:anylearn/dto/profilelikecmt/post_dto.dart';
import 'package:anylearn/widgets/icon_post_comment.dart';
import 'package:anylearn/widgets/textFieldcomment.dart';
import 'package:anylearn/widgets/text_count_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  PostDTO get post => widget.post;
  int likeCount = 0;
  bool isLiked = false;

  int get commentCount => post.commentCounts ?? 0;

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
            post.description != null &&
            post.description!.trim().isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 8),
            child: Text(
              post.description!,
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
                      if (widget.post.isLiked) {
                        setState(() {
                          widget.post.isLiked = false;
                          widget.post.likeCounts -= 1;
                        });
                      } else {
                        setState(() {
                          widget.post.isLiked = true;
                          widget.post.likeCounts += 1;
                        });
                        _controller
                            .reverse()
                            .then((value) => _controller.forward());
                      }
                    },
                    child: post == null
                        ? Container()
                        : post.isLiked
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
                      number: post.likeCounts,
                      subText: 'lượt thích',
                    ),
              post == null
                  ? Container()
                  : TextCountNumber(
                      number: post.commentCounts,
                      subText: 'bình luận',
                    ),
            ],
          ),
        )
      ],
    );
  }
}
