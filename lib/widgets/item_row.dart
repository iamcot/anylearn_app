import 'package:anylearn/dto/profilelikecmt/post_dto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemRow extends StatelessWidget {
  final PostDTO? post;
  final String? title;
  final String? avatarUrl;

  final String? subtitle;
  final Widget? avatarWidget;
  final Widget? bodyWidget;
  final Widget? rightWidget;
  

  const ItemRow({
    Key? key,
    this.post,
    this.avatarUrl,
    this.title,
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
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40 / 2),
                      child: CachedNetworkImage(imageUrl: avatarUrl!),
                    ),
                  ),
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
    if (post!.user!.name == null) {
      return const SizedBox();
    }

    return Flexible(
      child: Text(
        post!.title!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  Widget buildSubTitle(BuildContext context) {
    if (post!.day == null) {
      return const SizedBox();
    }
    return Container(
      margin: const EdgeInsets.only(top: 2),
      child: Text(
        post!.day,
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
