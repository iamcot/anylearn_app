import 'package:anylearn/dto/v3/registered_courses_dto.dart';
import 'package:anylearn/widgets/rating.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemCourse extends StatelessWidget {
  final RegisteredCourseDTO data;
  ItemCourse(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      
     return Container(
      width: 150,
      margin: EdgeInsets.only(right: 10),
      color: Colors.grey.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: data.courseImage, 
                  fit: BoxFit.cover, 
                  width: 150,
                  height: 100
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              Positioned(right: 0, child: _checkConfirmation(data.confirmed)),
            ],
          ),
          SizedBox(height: 5),
          Text(
            "[${data.subtype}] ${data.title}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ), 
          ),
          SizedBox(height: 5),
          RatingBox(score: data.rate, alignment: 'left', fontSize: 16),
        ]
      ),
    );
  }

  Widget _checkConfirmation(bool confirmed) {
    if (!confirmed) {
      return InkWell(
        onTap: () {
          print('!!!!!!!!!!!!!!!!');
        },
        child: _buildConfirmationStatusTag(confirmed),
      );
    }
    return _buildConfirmationStatusTag(confirmed);
  }

  Widget _buildConfirmationStatusTag(bool confirmed) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: confirmed ? Colors.green : Colors.grey,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6)) ,
        boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2), // Adjust the shadow offset as needed
            ),
          ],
      ),
      child: Text(
        confirmed ? 'Đang tham gia' : 'Chưa tham gia',
        style: TextStyle(
          color: Colors.white, 
          fontSize: 12,
          fontWeight: FontWeight.w500
          ),
      ),
    );
  }
}