import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../customs/custom_carousel.dart';
import '../../dto/article_dto.dart';
import '../../widgets/text2lines.dart';
import '../../widgets/time_ago.dart';
import '../../widgets/youtube_image.dart';

class ContentVideo extends StatefulWidget {
  final ArticleDTO data;
  const ContentVideo({key, required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContentVideo();
}

class _ContentVideo extends State<ContentVideo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.data.video)!, flags: YoutubePlayerFlags());
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
          widget.data.shortContent == null
              ? SizedBox(height: 0)
              : Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                    widget.data.shortContent,
                  ),
                ),
          // Text(data.title),
          Container(
            alignment: Alignment.topRight,
            child: TimeAgo(
              time: widget.data.createdAt,
            ),
          ),
          Divider(),

          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
              child: Text(
                "Các bài liên quan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            CustomCarousel(items: widget.data.related, builderFunction: _itemSlider, height: 170.0),
          ]),
        ],
      ),
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
                    child: YoutubeImage(
                      link: item.video,
                      fit: BoxFit.cover,
                    )),
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
