import 'dart:math' as math;

import 'package:anylearn/themes/role_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../dto/ask_dto.dart';
import '../../widgets/time_ago.dart';

class AskForumList extends StatelessWidget {
  final List<AskDTO> data;

  const AskForumList({key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return data.length == 0
        ? SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Text("Chưa có câu hỏi nào").tr()),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final itemIndex = index ~/ 2;
                if (index.isEven) {
                  return ListTile(
                    title: Text(
                      data[itemIndex].title,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 20),
                    ),
                    leading: data[itemIndex].userImage == null
                        ? SizedBox(height: 0)
                        : CircleAvatar(
                            radius: 20,
                            backgroundColor: roleColor(data[itemIndex].userRole),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundImage: CachedNetworkImageProvider(
                                data[itemIndex].userImage,
                              ),
                            ),
                          ),
                    isThreeLine: true,
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[itemIndex].content,
                          style: TextStyle(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Align(alignment: Alignment.centerRight, child: TimeAgo(time: data[itemIndex].createdAt))
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed("/ask/forum/thread", arguments: data[itemIndex].id);
                    },
                    trailing: Icon(Icons.chevron_right),
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
}
