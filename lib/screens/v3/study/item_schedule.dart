import 'package:anylearn/dto/v3/registered_courses_dto.dart';
import 'package:flutter/material.dart';

class ItemSchedule extends StatelessWidget {
  final RegisteredCourseDTO data;
  const ItemSchedule(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: constraints.maxWidth - 30,
                child: Text(
                  data.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
              SizedBox(height: 5),
               Row(
                children: [
                  Icon(Icons.school, size: 20, color: Colors.blue),
                  SizedBox(width: 5),
                  Text(data.author),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.schedule, size: 20, color: Colors.blue),
                  SizedBox(width: 5),
                  Text('${data.startTime} - ${data.endTime}',),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.location_on, size: 20, color: Colors.blue),
                  SizedBox(width: 5),
                  Text('9 Đ. Võ Thị Sáu, ĐaKao, Q1, HCM'),
                ],
              )
            ],
          ),
        );
      }
    );
  }
}