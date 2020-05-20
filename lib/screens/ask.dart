import 'package:anylearn/dto/ask_dto.dart';
import 'package:anylearn/screens/ask/ask_body.dart';
import 'package:anylearn/widgets/appbar.dart';
import 'package:anylearn/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

class AskScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AskScreen();
}

class _AskScreen extends State<AskScreen> {
  final Map<String, List<AskDTO>> data = {
    "watch": [
      AskDTO(title: "video 1", type: "watch", shortContent: "Giới thiệu ngắn", route: "https://www.youtube.com/watch?v=XCWfg_S4Bmc"),
      AskDTO(title: "video 2", type: "watch", shortContent: "Giới thiệu ngắn", route: "https://www.youtube.com/watch?v=XCWfg_S4Bmc"),
      AskDTO(title: "video 3", type: "watch", shortContent: "Giới thiệu ngắn", route: "https://www.youtube.com/watch?v=XCWfg_S4Bmc"),
    ],
    "read": [
      AskDTO(title: "Article 1", type: "read", shortContent: "Giới thiệu ngắn", route: "https://www.facebook.com/106596874379224/photos/gm.1042382279491299/120295656342679/"),
      AskDTO(title: "Article 2", type: "read", shortContent: "Giới thiệu ngắn", route: "https://www.facebook.com/106596874379224/photos/gm.1042382279491299/120295656342679/"),
      AskDTO(title: "Article 3", type: "read", shortContent: "Giới thiệu ngắn", route: "https://www.facebook.com/106596874379224/photos/gm.1042382279491299/120295656342679/"),
    ],
    "forum": [
       AskDTO(title: "Forum 1", type: "forum", shortContent: "Giới thiệu ngắn", route: "/ask"),
       AskDTO(title: "Forum 2", type: "forum", shortContent: "Giới thiệu ngắn", route: "/ask"),
       AskDTO(title: "Forum 3", type: "forum", shortContent: "Giới thiệu ngắn", route: "/ask"),
    ],
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Học & Hỏi",
      ),
      body: AskBody(data: data,),
      bottomNavigationBar: BottomNav(
        index: BottomNav.ASK_INDEX,
      ),
    );
  }
}
