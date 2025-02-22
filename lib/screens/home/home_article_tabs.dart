import 'dart:math';

import 'package:easy_localization/easy_localization.dart';

import '../../dto/const.dart';
import '../../widgets/youtube_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../dto/article_dto.dart';

class HomeArticleTabs extends StatefulWidget {
  final List<ArticleDTO> articles;
  final List<ArticleDTO> videos;

  const HomeArticleTabs({key, required this.articles, required this.videos}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HomeArticleTabs();
}

class _HomeArticleTabs extends State<HomeArticleTabs> with TickerProviderStateMixin {
  late TabController _tabController;
  late Map<String, List<ArticleDTO>> data;

  @override
  void didChangeDependencies() {
    int initTab = 0;
    try {
      initTab = int.parse(ModalRoute.of(context)!.settings.arguments.toString());
    }catch (e) {}
    _tabController =
        new TabController(vsync: this, length: 2, initialIndex: initTab);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return SliverToBoxAdapter(
        child: DefaultTabController(
      length: 2,
      child: Container(
        height: max(widget.articles.length * 130.0, widget.videos.length * 130.0),
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.blue,
              labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              unselectedLabelColor: Colors.black54,
              tabs: [
                Tab(
                  text: "Đọc để Học".tr(),
                ),
                Tab(
                  text: "Xem để học".tr(),
                ),
              ],
            ),
            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  // first tab bar view widget
                  Container(
                    child: Column(
                      children: widget.articles
                          .map((item) => ListTile(
                                contentPadding: EdgeInsets.all(5),
                                onTap: () => Navigator.of(context).pushNamed("/article", arguments: item.id),
                                leading: Container(
                                  height: 80,
                                  width: 80,
                                  child: _articleImg(item),
                                ),
                                trailing: Icon(Icons.chevron_right),
                                title: Text(
                                  item.title,
                                  maxLines: 2,
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                                ),
                                subtitle: Text(
                                  item.shortContent ?? "",
                                  maxLines: 3,
                                ),
                              ))
                          .toList(),
                    ),
                  ),

                  // second tab bar viiew widget
                  Container(
                    child: Column(
                      children: widget.videos
                          .map(
                            (item) => ListTile(
                              contentPadding: EdgeInsets.all(5),
                              onTap: () => Navigator.of(context).pushNamed("/article", arguments: item.id),
                              leading: Container(
                                height: 80,
                                width: 80,
                                child: _articleImg(item),
                              ),
                              title: Text(
                                item.title,
                                maxLines: 2,
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                              ),
                              subtitle: Text(
                                item.shortContent ?? "",
                                maxLines: 3,
                              ),
                            ),
                          ).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
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
