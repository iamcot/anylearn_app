import 'package:flutter/material.dart';

import '../../../dto/ask_dto.dart';

class HomeAsk extends StatelessWidget {
  final AskDTO ask;

  const HomeAsk({Key? key, required this.ask}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Thảo luận gần đây",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              Icon(Icons.chevron_right)
            ],
          ),
          SizedBox.fromSize(size: Size.fromHeight(10),),
          Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ask.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                  ),
                  Text(
                    ask.username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green,
                      height: 1.5
                    ),
                  ),
                  Text(
                    ask.content,
                    maxLines: 3,
                    style: TextStyle(fontSize: 18, height: 1.3),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: TextButton(onPressed: () {}, child: Text("ĐẾN THẢO LUẬN >")),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
