import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../dto/article_dto.dart';
import '../../widgets/text2lines.dart';
import '../../widgets/time_ago.dart';

class ContentVideo extends StatefulWidget {
  final ArticleDTO data;
  const ContentVideo({Key key, this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContentVideo();
}

class _ContentVideo extends State<ContentVideo> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.data.video),
        flags: YoutubePlayerFlags());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context, player) => ListView(
        children: [
          player,
          Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Text2Lines(
              text: widget.data.title,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
           widget.data.shortContent == null ? SizedBox(height: 0) : Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Text(
              widget.data.shortContent,
            ),
          ),
          // Text(data.title),
          Divider(),
          Container(
            alignment: Alignment.topRight,
            child: TimeAgo(
              time: widget.data.createdAt,
            ),
          )
        ],
      ),
    );
  }
}
