import 'package:anylearn/customs/custom_cached_image.dart';
import 'package:anylearn/customs/custom_carousel.dart';
import 'package:anylearn/screens/webview.dart';
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
        Html(
          data: data.content,
          shrinkWrap: true,
         onLinkTap: (String url, _, __, ___) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WebviewScreen(
                      url: url,
                    )));
          },
        ),
        Container(alignment: Alignment.topRight, child: TimeAgo(time: data.createdAt)),
        Divider(),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
            child: Text(
              "Các bài liên quan",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          CustomCarousel(items: data.related, builderFunction: _itemSlider, height: 170.0),
        ]),
      ],
    );
  }

  Widget _itemSlider(BuildContext context, dynamic item, double cardHeight) {
    double width = MediaQuery.of(context).size.width;
    width = width - width / 3;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("/article", arguments: item.id);
      },
      child: Card(
        child: Container(
          alignment: Alignment.topLeft,
          width: width,
          child: Column(
            children: [
              Container(
                height: cardHeight * 2 / 3,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0), topRight: Radius.circular(7.0)),
                  child: item.image != null && item.image.isNotEmpty
                      ? CustomCachedImage(url: item.image)
                      : Icon(Icons.broken_image),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(15.0),
                child: Text(
                  item.title ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
