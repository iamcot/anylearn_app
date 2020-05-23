import '../dto/ask_dto.dart';
import 'ask/ask_cat_body.dart';
import '../widgets/appbar.dart';
import '../widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

class AskCatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AskCatScreen();
}

class _AskCatScreen extends State<AskCatScreen> {
  final String catName = "Xem & Học";
  final List<AskDTO> data = [
    AskDTO(title: "video 1", type: "watch", shortContent: "Giới thiệu ngắn", route: "https://www.youtube.com/watch?v=XCWfg_S4Bmc"),
    AskDTO(title: "video 2", type: "watch", shortContent: "Giới thiệu ngắn", route: "https://www.youtube.com/watch?v=XCWfg_S4Bmc"),
    AskDTO(title: "video 3", type: "watch", shortContent: "Giới thiệu ngắn", route: "https://www.youtube.com/watch?v=XCWfg_S4Bmc"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: catName,
      ),
      body: AskCatBody(
        data: data,
      ),
      bottomNavigationBar: BottomNav(
        index: BottomNav.ASK_INDEX,
      ),
    );
  }
}
