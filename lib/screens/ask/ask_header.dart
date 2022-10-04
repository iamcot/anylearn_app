import 'package:anylearn/screens/ask_cat.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AskHeader extends StatelessWidget {
  final String title;
  final String type;
  final String route;

  const AskHeader({key, required this.title, this.type = "", this.route = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        Text('title');

    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
          ),
          InkWell(
            child: Text("XEM THÊM", style: TextStyle(color: Colors.blue, fontSize: 12.0)).tr(),
            onTap: () {
              if (type != "") {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return AskCatScreen(
                    type: type,
                  );
                }));
              } else if (route != "") {
                Navigator.of(context).pushNamed(route);
              }
            },
          )
        ],
      ),
    );
  }
}
