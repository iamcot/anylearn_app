import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../dto/article_dto.dart';
import '../../dto/const.dart';
import '../../widgets/youtube_image.dart';

class AskList extends StatelessWidget {
  final List<ArticleDTO> data;

  const AskList({key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
        Text('title').tr();

    final width = MediaQuery.of(context).size.width;
    final height = width * 0.5625;
    final imgHeight = height - 32;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final itemIndex = index ~/ 2;
          if (index.isEven) {
             return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("/article", arguments: data[itemIndex].id);
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: imgHeight,
                      width: double.infinity,
                      child: _articleImg(data[itemIndex]),
                    ),
                    Container(padding: EdgeInsets.all(15), child: Text(data[itemIndex].title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),
                    data[itemIndex].shortContent == null
                        ? SizedBox(height: 0)
                        : Container(
                            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                            child: Text(data[itemIndex].shortContent),
                          ),
                  ],
                ),
              ),
            );
          }
          return Divider(
            height: 0.0,
          );
        },
        semanticIndexCallback: (Widget widget, int localIndex) {
          if (localIndex.isEven) {
            return localIndex ~/ 2;
          }
          return null;
        },
        childCount: math.max(0, data.length * 2 - 1),
      ),
    );
  }

  Widget _buildTypeIcon(ArticleDTO _data) {
    if (_data.image != null) {
      return CachedNetworkImage(imageUrl: _data.image);
    }
    switch (_data.type) {
      case "video":
        return YoutubeImage(link: _data.video);
        break;
      case "read":
        return Icon(
          Icons.chrome_reader_mode,
          size: 32.0,
        );
        break;
      case "forum":
        return Icon(
          Icons.question_answer,
          size: 32.0,
        );
        break;
      default:
        return Icon(
          MdiIcons.cube,
          size: 32.0,
        );
    }
  }

   Widget _articleImg(ArticleDTO articleDTO) {
    if (articleDTO.type == MyConst.ASK_TYPE_VIDEO) {
      return YoutubeImage(
        link: articleDTO.video,
        fit: BoxFit.cover,
      );
    }
    return articleDTO.image == null
        ? SizedBox(height: 0)
        : CachedNetworkImage(
            imageUrl: articleDTO.image,
            fit: BoxFit.cover,
          );
  }
}
