import 'package:flutter/material.dart';
import 'package:simple_tags/simple_tags.dart';

class LastSearch extends StatelessWidget {
  final List<String> data;
  final Function callback;

  const LastSearch({Key? key, required this.data, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tìm kiếm gần đây', style: Theme.of(context).textTheme.titleMedium),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 30),
            child: SimpleTags (
              content: data,
              wrapSpacing: 10,
              wrapRunSpacing: 12,
              onTagPress: (tag) => callback(context, tag),
              tagContainerPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              //tagTextStyle: TextStyle(color: Colors.blue),
              //tagIcon: Icon(Icons.search, size: 12),
              tagContainerDecoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}