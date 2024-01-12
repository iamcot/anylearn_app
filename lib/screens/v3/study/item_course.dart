import 'package:anylearn/dto/v3/registered_courses_dto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemCourse extends StatelessWidget {
  static const CONFIRMATION_TYPE = 'confirmation';
  static const COMPLETION_TYPE = 'completion';

  final RegisteredCourseDTO data;
  final String type;
  
  ItemCourse({ 
    Key? key, 
    required this.data, 
    this.type = CONFIRMATION_TYPE
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
        return InkWell(
          onTap: () => print('Show info'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: data.courseImage, 
                      fit: BoxFit.cover, 
                      width: constraints.maxWidth,
                      height: 99,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  if (CONFIRMATION_TYPE == type)
                  Positioned(right: 0, bottom: 0, child: _buildConfimationTag(context)),
                ],
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 35,
                child: Text(
                  data.title,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold), 
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    children: [
                      CONFIRMATION_TYPE == type 
                        ? Icon(Icons.local_library, color: Colors.grey, size: 15)
                        : Icon(Icons.workspace_premium, color: Colors.amber, size: 15),
                      const SizedBox(width: 2),
                      Text(
                        CONFIRMATION_TYPE == type ? data.startDate : data.endDate,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      Icon(Icons.grade, color: Colors.amber, size: 15),
                      Text(
                        data.rating.toString(), 
                        style: TextStyle(fontSize: 14),
                      )
                    ]
                  ),
                ],
              )
            ]
          ),
        );
      }
    );
  }

  Widget _buildConfimationTag(BuildContext context) {
    return InkWell(
      onTap: () => data.confirmed 
        ? _buildConfimationSnackBar(context)
        : _buildConfimationDialog(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6), // Adjust the radius as needed
            bottomRight: Radius.circular(6))),
        child: Row(
          children: [
            Icon(
              data.confirmed ? Icons.check : Icons.info_outline,
              color: Colors.white,
              size: 15,
            ),
            const SizedBox(width: 3),
            Text(
              data.confirmed ? 'Đang tham gia' : 'Chưa tham gia',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _buildConfimationDialog(BuildContext context) {
    showDialog(
      context: context, 
      builder: (context) =>  AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(
          'Xác nhận tham gia ${data.title}?',
          style: TextStyle(fontSize: 15, color: Colors.grey.shade800)),
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        actionsPadding: EdgeInsets.fromLTRB(20, 0, 20, 10),
        actions: [
          TextButton(
            onPressed: () => 'Confirmation!',
            child: Text('Tham gia')),
          TextButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: Text('Đóng')
          ),
        ],
      ),
    );
  }

   void _buildConfimationSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(
        content: Text('Bạn đang tham gia khóa học này.'),
        backgroundColor: Colors.black.withOpacity(.5),  
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      )
    );
  }
}