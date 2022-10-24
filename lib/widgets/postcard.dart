import 'package:anylearn/assettest.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../blocs/account/account_bloc.dart';
import '../blocs/account/account_blocs.dart';
import '../blocs/account/account_event.dart';
import '../models/user_repo.dart';
import '../screens/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dto/likecomment/post_dto.dart';
import 'headerButtonSection.dart';
import 'varfied.dart';

class PostCard extends StatefulWidget {
  final PostDTO post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
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
        HeaderButtonSection(
            buttonOne: headerbutton(
                buttontext: "Like",
                buttonicon: Icons.thumb_up_alt_outlined,
                buttonaction: () {},
                buttoncolor: Colors.grey),
            buttonTwo: headerbutton(
                buttontext: "comment",
                buttonicon: Icons.mode_comment_outlined,
                buttonaction: () {},
                buttoncolor: Colors.grey),
            buttonThree: headerbutton(
                buttontext: "share",
                buttonicon: Icons.share_outlined,
                buttonaction: () {},
                buttoncolor: Colors.grey))
      ],
    ));
  }

  Widget titleSection() {
    return widget.post.title != null && widget.post.title != ""
        ? Container(
            padding: EdgeInsets.only(bottom: 5, left: 10, right: 10),
            child: Text(
              widget.post.title == null ? "N/A" : widget.post.title.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          )
        : SizedBox();
  }

  Widget imageSection() {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Image.asset("assets/test/2.png"),
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
                  width: 1,
                ),
                displayText(label: widget.post.likes.toString()),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                displayText(label: widget.post.comments.toString()),
                SizedBox(
                  width: 5,
                ),
                displayText(label: "Comments"),
                SizedBox(
                  width: 10,
                ),
                displayText(label: widget.post.share.toString()),
                SizedBox(
                  width: 5,
                ),
                displayText(label: "Share"),
                // CircleAvatar(
                //   radius: 50,
                // ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
        child: (widget.post.user!.image != "")
            ? CircleAvatar(
                backgroundImage:
                    CachedNetworkImageProvider(widget.post.user!.image),
                radius: 50,
              )
            : Icon(
                Icons.account_circle,
                color: Colors.grey,
              ),
        // backgroundImage: CachedNetworkXImageProvider(
        //   widget.post.user!.image),
        //   radius: 50,
      ),
      title: Row(
        children: [
          Text(
            widget.post.user.toString(),
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(width: 10),
          widget.post.status.isOdd ? Varfied() : SizedBox(),
        ],
      ),
      subtitle: Row(
        children: [
          Text(widget.post.createdAt != null
              ? widget.post.createdAt.toString()
              : "N/A"),
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
