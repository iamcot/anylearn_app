import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class YoutubeImage extends StatelessWidget {
  final link;
  final fit;

  const YoutubeImage({this.link, this.fit});
  @override
  Widget build(BuildContext context) {
    final image = _videoThumbURL(link);
    return CachedNetworkImage(imageUrl: image, fit: fit ?? BoxFit.contain,);
  }

  String _videoThumbURL(String yt) {
    String id = _getVideoIdFromUrl(yt);
    return "https://img.youtube.com/vi/$id/0.jpg";
  }

  String _getVideoIdFromUrl(String url) {
    // For matching https://youtu.be/<VIDEOID>
    RegExp regExp1 = new RegExp(r"youtu\.be\/([^#\&\?]{11})", caseSensitive: false, multiLine: false);
    // For matching https://www.youtube.com/watch?v=<VIDEOID>
    RegExp regExp2 = new RegExp(r"\?v=([^#\&\?]{11})", caseSensitive: false, multiLine: false);
    // For matching https://www.youtube.com/watch?x=yz&v=<VIDEOID>
    RegExp regExp3 = new RegExp(r"\&v=([^#\&\?]{11})", caseSensitive: false, multiLine: false);
    // For matching https://www.youtube.com/embed/<VIDEOID>
    RegExp regExp4 = new RegExp(r"embed\/([^#\&\?]{11})", caseSensitive: false, multiLine: false);
    // For matching https://www.youtube.com/v/<VIDEOID>
    RegExp regExp5 = new RegExp(r"\/v\/([^#\&\?]{11})", caseSensitive: false, multiLine: false);

    String matchedString = "";

    if (regExp1.hasMatch(url)) {
      matchedString = regExp1.firstMatch(url)!.group(0)!;
    } else if (regExp2.hasMatch(url)) {
      matchedString = regExp2.firstMatch(url)!.group(0)!;
    } else if (regExp3.hasMatch(url)) {
      matchedString = regExp3.firstMatch(url)!.group(0)!;
    } else if (regExp4.hasMatch(url)) {
      matchedString = regExp4.firstMatch(url)!.group(0)!;
    } else if (regExp5.hasMatch(url)) {
      matchedString = regExp5.firstMatch(url)!.group(0)!;
    }

    return matchedString.substring(matchedString.length - 11);
  }
}
