import 'dart:io';
import 'dart:math' as math;

import 'package:anylearn/dto/ask_dto.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AskList extends StatelessWidget {
  final List<AskDTO> data;

  const AskList({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final itemIndex = index ~/ 2;
        if (index.isEven) {
          return ListTile(
            leading: Icon(
              _buildTypeIcon(data[itemIndex].type),
              size: 32.0,
            ),
            title: Text(data[itemIndex].title),
            subtitle: Text(data[itemIndex].shortContent),
            trailing: Icon(Icons.arrow_right),
            onTap: ()  {
               _actionWithRoute(data[itemIndex].type, data[itemIndex].route);
            },
          );
        }
        return Divider(
          height: 0.0,
        );
      }, semanticIndexCallback: (Widget widget, int localIndex) {
        if (localIndex.isEven) {
          return localIndex ~/ 2;
        }
        return null;
      }, childCount: math.max(0, data.length * 2 - 1),
      ),
    );
  }

  IconData _buildTypeIcon(String type) {
    switch (type) {
      case "watch":
        return Icons.video_library;
        break;
      case "read":
        return Icons.chrome_reader_mode;
        break;
      case "forum":
        return Icons.question_answer;
        break;
      default:
        return MdiIcons.cube;
    }
  }

  Future<void> _actionWithRoute(String type, String route) async {
    if (type == "watch" || type == "read") {
      if (Platform.isIOS) {
        if (await canLaunch(route)) {
          await launch(route, forceSafariVC: false);
        } else {
          if (await canLaunch(route)) {
            await launch(route);
          } else {
            throw 'Could not launch';
          }
        }
      } else {
        // const url = 'youtube://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
        if (await canLaunch(route)) {
          await launch(route);
        } else {
          throw 'Could not launch';
        }
      }
    }
    return;
  }
}
