import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../dto/article_dto.dart';
import '../../../dto/const.dart';
import '../../../widgets/youtube_image.dart';

class HomeArticles extends StatelessWidget {
  final List<ArticleDTO> articles;

  const HomeArticles({key, required this.articles}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final imgHeight = (width / 2) * 0.7;
    return Container(
      padding: EdgeInsets.only(left: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
            child: Row(
              children: [
                Expanded(
                  child: Text("Tin tức anyLEARN", style: TextStyle(                          
                    fontWeight: FontWeight.bold,
                    fontSize: 18,  
                    height: 1.1,
                  )),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 10, right: 15),
              height: (articles.length / 2).ceil() * ((width / 2) + 60),
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 0.7,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: List<ArticleDTO>.from(articles)
                    .map((article) => Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed("/article", arguments: article.id);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: imgHeight,
                                  width: double.infinity,
                                  child: _articleImg(article),
                                ),
                                Container(
                                    height: 40,
                                    margin: EdgeInsets.only(top: 15),
                                    child: Text(
                                      article.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    )),
                                article.shortContent == null
                                    ? SizedBox(height: 0)
                                    : Container(
                                      height: 40,
                                        margin: EdgeInsets.only(top: 5, bottom: 15),
                                        child: Text(
                                          article.shortContent,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              )),
        ],
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
        ? Image.asset(
            "assets/images/logo_app.jpg",
            fit: BoxFit.contain,
          )
        : CachedNetworkImage(
            imageUrl: articleDTO.image,
            fit: BoxFit.cover,
          );
  }
}
