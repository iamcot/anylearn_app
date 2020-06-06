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
      AskDTO(title: 'Học "nghề" làm cha mẹ. Tại sao không?', type: "watch", shortContent: '', route: "https://www.youtube.com/watch?v=bg_dF5URoWQ"),
      AskDTO(title: "Covid sẽ bỏ chạy ngay khi bạn làm theo lời khuyên của chuyên gia", type: "watch", shortContent: "", route: "https://www.youtube.com/watch?v=hEVJWtxw5d0"),
      AskDTO(title: "Dạy con tránh xa nguy hiểm", type: "watch", shortContent: "", route: "https://www.youtube.com/watch?v=3IZqZpN-_rU"),
    ],
    "read": [
      AskDTO(title: "Khủng hoảng tuổi lên 2", type: "read", shortContent: "", route: "https://www.facebook.com/permalink.php?story_fbid=120049519700626&id=106596874379224&__tn__=K-R"),
      AskDTO(title: "Những website giúp luyện kĩ năng nghe TOEIC & IELTS", type: "read", shortContent: "", route: "https://www.facebook.com/106596874379224/photos/a.115750160130562/117069976665247/?type=3&theater"),
      AskDTO(title: "Khoảng trống miễn dịch ở trẻ", type: "read", shortContent: "", route: "https://www.facebook.com/106596874379224/photos/a.115734663465445/121179776254267/?type=3&theater"),
    ],
    "forum": [
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
