import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../dto/const.dart';
import '../dto/profilelikecmt/post_dto.dart';
import '../screens/commentpage.dart';
import 'time_ago.dart';
import 'varfied.dart';

class PostCard extends StatefulWidget {
  PostDTO post;
  // final ActionDTO type;

  PostCard({Key? key, required this.post}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          postCardHeader(),
          titleSection(),
          imageSection(),
          footerSection(),
          Divider(
            thickness: 1,
            color: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                  onPressed: () {
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
                  // onPressed: () {
                  //   setState(()  {
                  //     _isLiked = !_isLiked;
                  //   });
                  //   _controller
                  //       .reverse()
                  //       .then((value) => _controller.forward());
                  // },
                  icon: widget.post == MyConst.TYPE_ACTION_LIKE
                      ? Icon(
                          Icons.thumb_up_alt_outlined,
                          color: Colors.blue,
                        )
                      : Icon(Icons.thumb_up_alt_outlined, color: Colors.grey),
                  label: widget.post == MyConst.TYPE_ACTION_LIKE
                      ? Text("Thích".tr(), style: TextStyle(color: Colors.blue))
                      : Text(
                          "Thích".tr(),
                          style: TextStyle(color: Colors.grey),
                        )),
              TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CommentPage()));
                  },
                  icon: Icon(Icons.mode_comment_sharp, color: Colors.grey),
                  label: Text(
                    "Bình Luận".tr(),
                    style: TextStyle(color: Colors.grey),
                  )),
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.screen_share_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Chia sẻ".tr(),
                    style: TextStyle(color: Colors.grey),
                  )),
            ],
          ),
          Divider(
            thickness: 10,
            color: Colors.grey[300],
          ),
        ],
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

  Widget imageSection() {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: CachedNetworkImage(
        imageUrl: widget.post.images.toString(),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget footerSection() {
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  height: 15,
                  width: 15,
                  child: Icon(
                    Icons.thumb_up,
                    color: Colors.white,
                    size: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                displayText(
                    label: numberFormat(widget.post.likeCounts.toInt())),
              ],
            ),
          ),
          SizedBox(
            width: 50,
          ),
          widget.post.commentCounts == 0
              ? Container()
              : Container(
                  child: Row(
                    children: [
                      displayText(
                          label:
                              numberFormat(widget.post.commentCounts.toInt())),
                      SizedBox(
                        width: 5,
                      ),
                      displayText(label: "Comments"),

                      // CircleAvatar(
                      //   radius: 50,
                      // ),
                    ],
                  ),
                ),
          // SizedBox(
          //   width: 50,
          // ),
          widget.post.shareCounts == 0
              ? Container()
              : Container(
                  child: Row(
                    children: [
                      displayText(
                          label: numberFormat(widget.post.shareCounts.toInt())),
                      SizedBox(
                        width: 5,
                      ),
                      displayText(label: "Share"),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }

  String numberFormat(int n) {
    String num = n.toString();
    int len = num.length;

    if (n >= 1000 && n < 1000000) {
      return num.substring(0, len - 3) +
          '.' +
          num.substring(len - 3, 1 + (len - 3)) +
          'k';
    } else if (n >= 1000000 && n < 1000000000) {
      return num.substring(0, len - 6) +
          '.' +
          num.substring(len - 6, 1 + (len - 6)) +
          'm';
    } else if (n > 1000000000) {
      return num.substring(0, len - 9) +
          '.' +
          num.substring(len - 9, 1 + (len - 9)) +
          'b';
    } else {
      return num.toString();
    }
  }

  Widget displayText({required String label}) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.grey[700],
      ),
    );
  }

  Widget postCardHeader() {
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.white30,
        child: (widget.post.user!.image != "")
            ? CircleAvatar(
                backgroundImage:
                    CachedNetworkImageProvider(widget.post.user!.image),
              )
            : Icon(
                Icons.account_circle,
                color: Colors.grey,
                size: 56,
              ),
      ),
      title: Row(
        children: [
          Text(
            widget.post.user!.name,
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(width: 10),
          widget.post.status == 1 ? Varfied() : SizedBox(),
        ],
      ),
      subtitle: Row(
        children: [
          TimeAgo(time: widget.post.createdAt) != null
              ? TimeAgo(time: widget.post.createdAt)
              : SizedBox(),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.public,
            color: Colors.grey[700],
            size: 15,
          )
        ],
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.more_horiz,
          color: Colors.grey[700],
        ),
      ),
    );
  }
  
}

Future<void> updateLikes({String? id, int? value}) async {
  var brewCollection;
  var FieldValue;
  return await brewCollection
      .document(id)
      .updateData({'likes': FieldValue.increment(value)});
}
