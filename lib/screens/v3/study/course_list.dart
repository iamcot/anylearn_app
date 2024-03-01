import 'package:anylearn/widgets/title_text.dart';
import 'package:flutter/material.dart';

class CourseList extends StatelessWidget {
  final String title;
  final String intro;
  final List<dynamic> data;

  final Axis scrollDirection;
  final String itemType; 
  final Widget? additional;
  final Widget Function(dynamic course, String type) itemBuilder;
  final Route Function(int orderItemID) linkBuilder;

  CourseList({
    Key? key, 
    required this.title,
    required this.data,
    required this.itemBuilder,
    required this.linkBuilder,
    this.additional,
    this.scrollDirection = Axis.horizontal,
    this.itemType = '',
    this.intro = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(title),
          Padding(
            padding: EdgeInsets.only(top: 10.0, right: 20.0),
            child: Row(
              children: [
                Text(intro),
                if (null != additional) additional!, 
              ],
            ),
          ),
         
          const SizedBox(height: 10.0),
          _buildListView(context),
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    final listWidth = MediaQuery.of(context).size.width - 20;
    final itemWidth = Axis.horizontal == scrollDirection ? listWidth / 2.45 : listWidth - 20; 
    return SizedBox(
      width: Axis.horizontal == scrollDirection ? listWidth : listWidth - 20,
      height: Axis.horizontal == scrollDirection ? itemWidth : null,
      child: ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: scrollDirection,  
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Container(
            width: itemWidth,
            margin: Axis.horizontal == scrollDirection 
              ? EdgeInsets.only(right: 10) 
              : data.length - 1  != index ? EdgeInsets.only(bottom: 10) : null,
            decoration: BoxDecoration(
              // color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              child: itemBuilder(data[index], itemType),
              onTap: () => Navigator.of(context).push(linkBuilder(data[index].orderItemID)),
            ),
          );
        }
      ),
    );
  }
}