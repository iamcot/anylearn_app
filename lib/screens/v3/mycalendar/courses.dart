import 'package:flutter/material.dart';

class Courses extends StatelessWidget {
  final String title;
  final String intro;

  final num itemHeight;
  final num itemWidth;
  final Widget Function(int index) itemBuilder;

  Courses({
    Key? key, 
    required this.title,
    required this.intro,
    this.itemHeight = 150, 
    this.itemWidth = 160,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              title, 
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,    
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              intro, 
              style: TextStyle(
                fontSize: 16, 
                color: Colors.grey.shade900,
              )
            ),
          ),
          SizedBox(
            height: itemHeight.toDouble(),
            child: ListView.builder(    
              physics: ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (context, index) => itemBuilder(index),
            ),
          ),
        ],
      )
    );
  }
}