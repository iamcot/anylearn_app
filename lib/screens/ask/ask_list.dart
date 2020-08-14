import 'dart:math' as math;

import 'package:anylearn/widgets/youtube_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../dto/article_dto.dart';

class AskList extends StatelessWidget {
  final List<ArticleDTO> data;

  const AskList({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final itemIndex = index ~/ 2;
          if (index.isEven) {
            return ListTile(
              leading: _buildTypeIcon(data[itemIndex]),
              title: Text(data[itemIndex].title),
              subtitle: Text(data[itemIndex].shortContent == null ? "" : data[itemIndex].shortContent),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pushNamed("/article", arguments: data[itemIndex].id);
              },
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
}
