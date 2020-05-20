import 'package:flutter/material.dart';

class AskHeader extends StatelessWidget {
  final String title;
  final String route;

  const AskHeader({Key key, this.title, this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.grey[600])),
          ),
          InkWell(
            child: Text("XEM THÊM", style: TextStyle(color: Colors.blue, fontSize: 12.0)),
            onTap: () {
              Navigator.of(context).pushNamed(route);
            },
          )
        ],
      ),
    );
  }
}
