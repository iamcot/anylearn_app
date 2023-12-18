import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Greeting extends StatelessWidget {
  final int studentID;
  final int numCourses;
  final String studentImage;
  final List<dynamic> studentList;

  const Greeting({
    Key? key, 
    required this.studentID, 
    required this.numCourses,
    required this.studentImage,
    required this.studentList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final student = _getStudentName(studentID, studentList);
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chào ${student['name']},',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                      text:  'Bạn có ',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 18,
                      ),
                      children: [
                        TextSpan(
                          text: '2 lớp học hôm nay',
                          style: TextStyle(
                            color: Colors.green.shade400, 
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => print('Show Calendar!'),
                        )
                      ]
                    )
                  ),
                ],
              ),
              InkWell(
                onTap: () => print('Change Student'),
                child: Stack(
                  children: [
                    SizedBox(      
                      width: 45,
                      height: 45,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: studentImage, 
                          fit: BoxFit.cover, 
                          errorWidget: ((context, url, error) => Icon(
                            Icons.account_circle, 
                            size: 50, 
                            color: Colors.grey.shade400
                          )),
                        ),
                      )
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Icon(
                          Icons.change_circle, 
                          size: 14, 
                          color: Colors.white,
                        )
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          
        ]
      )
    );
  }
  Map<dynamic, dynamic> _getStudentName(int studentID, List<dynamic> studentList) {
    return studentList.firstWhere(
      (student) => student['id'] == studentID, 
      orElse: () => null ?? {}
    );
  }
  
}