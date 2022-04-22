import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../dto/article_dto.dart';
import '../../dto/const.dart';
import '../../widgets/youtube_image.dart';

class HomeArticles extends StatelessWidget {
  final List<ArticleDTO> articles;

  const HomeArticles({key, required this.articles}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = width * 0.5625;
    final imgHeight = height - 32;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final int itemIndex = index ~/ 2;
          if (index.isEven) {
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("/article", arguments: articles[itemIndex].id);
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: imgHeight,
                      width: double.infinity,
                      child: _articleImg(articles[itemIndex]),
                    ),
                    Container(padding: EdgeInsets.all(15), child: Text(articles[itemIndex].title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),
                    articles[itemIndex].shortContent == null
                        ? SizedBox(height: 0)
                        : Container(
                            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                            child: Text(articles[itemIndex].shortContent),
                          ),
                  ],
                ),
              ),
            );
          }
          return Divider(
            height: 10,
            color: Colors.transparent,
          );
        },
        childCount: math.max(0, articles.length * 2 - 1),
        semanticIndexCallback: (Widget widget, int localIndex) {
          if (localIndex.isEven) {
            return localIndex ~/ 2;
          }
          return null;
        },
      ),
    );
  }

  Widget _articleImg(ArticleDTO articleDTO) {
    if (articleDTO.type == MyConst.ASK_TYPE_VIDEO) {
      return YoutubeImage(
        link: articleDTO.video,
        fit: BoxFit.cover,
      );
    }
    return articleDTO.image == null
        ? Image.asset("assets/images/logo_app.jpg", fit: BoxFit.contain,)
        : CachedNetworkImage(
            imageUrl: articleDTO.image,
            fit: BoxFit.cover,
          );
  }
}
