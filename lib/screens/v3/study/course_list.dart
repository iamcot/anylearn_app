import 'package:anylearn/dto/v3/registered_courses_dto.dart';
import 'package:flutter/material.dart';

class CourseList extends StatelessWidget {
  final String title;
  final String intro;

  final num itemHeight;
  final num itemWidth;

  final List<dynamic> data;
  final Widget Function(RegisteredCourseDTO course) itemBuilder;

  CourseList({
    Key? key, 
    required this.title,
    required this.intro,
    required this.data,
    required this.itemBuilder,
    this.itemHeight = 160, 
    this.itemWidth = 160,
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
              itemCount: data.length,
              itemBuilder: (context, index) => itemBuilder(data[index]),
            ),
          ),
        ],
      )
    );
  }
}