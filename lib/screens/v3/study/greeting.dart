import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/screens/v3/study/conversion_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Greeting extends StatelessWidget {
  final int numCourses;
  final UserDTO userInfo;
  final List<dynamic> userAccounts;
  final Function(UserDTO account) changeAccountCallback;

  const Greeting({
    Key? key,
    required this.numCourses,
    required this.userInfo,
    required this.userAccounts,
    required this.changeAccountCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _buildStudyInfo(context)),
          const SizedBox(width: 10),
          InkWell(
            child: _buildStudentAvatar(context),
            onTap: () => showDialog(
              context: context,
              builder: (context) => ConversionDialog(
                userID: userInfo.id,
                userAccounts: userAccounts,
                changeAccountCallback: changeAccountCallback
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget _buildStudyInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chào ${userInfo.name} 🌻',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            text: 'Bạn có ',
            style: TextStyle(color: Colors.grey.shade800, fontSize: 16),
            children: [
              TextSpan(
                text: '$numCourses lớp học ',
                style: TextStyle(
                  color: Colors.blue.shade300,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => print('Show Calendar!'),
              ),
              TextSpan(text: 'hôm nay.')
            ]
          )
        ),
      ],
    );
  }

  Widget _buildStudentAvatar(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: userInfo.image,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Icon(
                Icons.account_circle,
                color: Colors.grey.shade300,
                size: 50
              ),
            ),
          ),
          width: 45,
          height: 45,
        ),
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Icon(Icons.change_circle, color: Colors.white, size: 14)
          ),
          right: 0,
          bottom: 0,
        )
      ],
    );
  }
}
