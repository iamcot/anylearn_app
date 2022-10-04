import 'package:anylearn/screens/webview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

import '../dto/guide_dto.dart';

class AccountAboutScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountAboutScreen();
}

class _AccountAboutScreen extends State<AccountAboutScreen> {
  final GuideDTO guide = GuideDTO(
    title: "Thông tin về anyLEARN.vn".tr(),
    content:
        "<p>Content in html</p><p> Has Image <img src=\"https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg\" /> </p>",
    lastUpdate: "2020-05-19 19:00:00",
  );
  @override
  Widget build(BuildContext context) {
        Text('title');

    DateFormat f = DateFormat("dd/MM/yyyy");
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Giới thiệu".tr()),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
            child: Text(
              guide.title,
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.grey[600]),
            ),
          ),
          Html(
            data: guide.content,
            shrinkWrap: true,
            onLinkTap: (url, _, __, ___) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WebviewScreen(
                        url: url!,
                      )));
            },
          ),
          Divider(),
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(right: 10.0),
            child: Text(
              " Cập nhật ngày: ".tr() + f.format(DateTime.parse(guide.lastUpdate)),
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10.0),
            ),
          ),
        ],
      ),
    );
  }
}
