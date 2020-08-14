import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../dto/article_dto.dart';
import '../../widgets/text2lines.dart';
import '../../widgets/time_ago.dart';

class ContentRead extends StatelessWidget {
  final ArticleDTO data;

  const ContentRead({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        data.image == null
            ? SizedBox(
                height: 0,
              )
            : CachedNetworkImage(imageUrl: data.image),
        Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: Text2Lines(
            text: data.title,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Html(data: data.content,),
        Divider(),
        Container(alignment: Alignment.topRight, child: TimeAgo(time: data.createdAt))
      ],
    );
  }
}
