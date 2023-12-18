import 'package:anylearn/dto/v3/registered_courses_dto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemCourse extends StatelessWidget {
  static const CONFIRMATION_TYPE = 'confirmation';
  static const COMPLETION_TYPE = 'completion';

  final RegisteredCourseDTO data;
  final String type;
  ItemCourse({ Key? key, required this.data, this.type = CONFIRMATION_TYPE}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
        return InkWell(
          onTap: () => print('Show info'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: data.courseImage, 
                  fit: BoxFit.cover, 
                  width: constraints.maxWidth,
                  height: 110,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              SizedBox(height: 5),
              SizedBox(
                height: 35,
                child: Text(
                  data.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800
                  ), 
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (CONFIRMATION_TYPE == type)
                  InkWell(
                    onTap: () => print('Confirmation'),
                    child: Row(
                      children: [
                        Icon(
                          Icons.group,            
                          size: 15,
                          color: data.confirmed ? Colors.green.shade400 : Colors.grey,
                        ),
                        SizedBox(width: 5.0),
                        Text(data.confirmed ? 'Đang tham gia' : 'Chưa tham gia'),
                      ],
                    ),
                  ),
                  if (COMPLETION_TYPE == type)
                  Row (
                    children: [
                      Icon(
                        Icons.workspace_premium,            
                        size: 15,
                        color: Colors.green.shade400,
                      ),
                      Icon(
                        Icons.workspace_premium,            
                        size: 15,
                        color: Colors.green.shade400,
                      ),
                      SizedBox(width: 5.0),
                      Text('21/12/2030'),
                    ],
                  ),    
                  InkWell(
                    onTap: () => print('Rating'),
                    child: Row(
                      children: [
                        Icon(Icons.grade, size: 15, color: Colors.orange.shade300),
                        Text(data.rating.toString()),
                      ],
                    ),
                  ),
                ],
              ),           
            ]
          ),
        );
      }
    );
  }

  Widget _checkConfirmationStatus(bool confirmed) {
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
    return  Row(
      children: [
        Icon(
          Icons.group,            
          size: 18,
          color:confirmed ? Colors.green : Colors.grey,
        ),
        SizedBox(width: 5.0),
        Text(confirmed ? 'Đang tham gia' : 'Chưa tham gia',),
      ],
    );    
  }
}