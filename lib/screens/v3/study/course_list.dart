import 'package:anylearn/dto/v3/registered_courses_dto.dart';
import 'package:flutter/material.dart';

class CourseList extends StatelessWidget {
  final String title;
  final String intro;
  final List<dynamic> data;

  final double itemHeight;
  final double itemWidth;
  final String itemType; 
  final Axis scrollDirection;
  final Widget Function(RegisteredCourseDTO course, String type) itemBuilder;

  CourseList({
    Key? key, 
    required this.title,
    required this.data,
    required this.itemBuilder,
    this.scrollDirection = Axis.horizontal,
    this.itemHeight = 160,
    this.itemWidth = 160,
    this.itemType = '',
    this.intro = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title, 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Text(intro),
          ),
          const SizedBox(height: 10),
          _buildListView(context),
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    return SizedBox(
      height: Axis.horizontal == scrollDirection ? itemHeight : null,
      child: ListView.builder(
        physics: ScrollPhysics(),
        scrollDirection: scrollDirection,
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Container(
            width: itemWidth,
            height: itemHeight,
            margin: Axis.horizontal == scrollDirection 
              ? EdgeInsets.only(right: 10) 
              : EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              // color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(10)),
            child: itemBuilder(data[index], itemType),
          );
        }
      ),
    );
  }
}