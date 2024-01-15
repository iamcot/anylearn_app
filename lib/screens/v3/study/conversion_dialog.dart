import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ConversionDialog extends StatelessWidget {
  final Function(int studentID) changeAccountCallback;
  final List<dynamic> studentList;
  final int studentID;

  const ConversionDialog({
    Key? key,
    required this.studentID,
    required this.studentList,
    required this.changeAccountCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text('Chọn tài khoản'),
      titleTextStyle: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: Colors.grey.shade800
      ),
      titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      content: Container(
        height: 105,
        width: double.maxFinite,
        child: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: studentList.length,
          itemBuilder: (BuildContext context, int index) {
            final subtitle = studentList[index]['primary'] == false
              ? 'Ngày tạo: ${studentList[index]['created_at']}'
              : 'Tài khoản chính';
            return InkWell(
              onTap: () => changeAccountCallback(studentList[index]['id']),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child:
                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: studentList[index]['image'],
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: Icon(Icons.person, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          studentList[index]['student'],
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade800,
                              overflow: TextOverflow.ellipsis),
                        ),
                        SizedBox(height: 3),
                        Text(subtitle, style: TextStyle(fontSize: 14))
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    // color: Colors.amber,
                    width: 30,
                    child: Icon(
                      Icons.check,
                      color: studentList[index]['id'] == studentID
                        ? Colors.green.shade400
                        : Colors.transparent
                    ),
                  )
                ]),
              ),
            );
          },
        ),
      ),
      actionsPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      actions: [
        SizedBox(
          height: 35,
          width: 50,
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Đóng'),
          ),
        ),
      ],
    );
  }
}
