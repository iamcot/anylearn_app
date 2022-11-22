import 'package:anylearn/dto/profilelikecmt/post_dto.dart';
import 'package:anylearn/main.dart';
import 'package:anylearn/widgets/time_ago.dart';
import 'package:anylearn/widgets/varfied.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemRow extends StatelessWidget {
  PostDTO post;

  final String? subtitle;
  final Widget? avatarWidget;
  final Widget? bodyWidget;
  final Widget? rightWidget;

  ItemRow({
    Key? key,
    required this.post,
    this.subtitle,
    this.avatarWidget,
    this.bodyWidget,
    this.rightWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              avatarWidget ??
                  CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white30,
                      child: (user.image != "")
                          ? CircleAvatar(
                              backgroundImage:
                                  CachedNetworkImageProvider(user.image),
                            )
                          : Icon(
                              Icons.account_circle,
                              color: Colors.grey,
                              size: 45,
                            )),
              const SizedBox(width: 8),
              bodyWidget ?? buildBodyWidget(context),
            ],
          ),
        ),
        rightWidget ?? const SizedBox(),
      ],
    );
  }

  Widget buildBodyWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildTitle(context),
        buildSubTitle(context),
      ],
    );
  }

  Widget buildTitle(BuildContext context) {
    if (user.name == null) {
      return const SizedBox();
    }

    return Flexible(
      child: post == null
          ? Container()
          : Text(
              user.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
    );
  }

  Widget buildSubTitle(BuildContext context) {
    if (post.displayTimePostCreated == null) {
      return const SizedBox();
    }
    return Container(
      margin: const EdgeInsets.only(top: 2),
      child: Text(
        post.displayTimePostCreated,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: Colors.grey[600]),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
