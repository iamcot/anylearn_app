import 'package:flutter/material.dart';

class CourseInfo extends StatelessWidget {
  const CourseInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(
      fontSize: 18,
    );
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Khóa học: Lớp học ELSA TL1', style: style),
          Text('Hình thức: Digital', style: style),
          Text('Thông tin:', style: style),
          Container(
            color: Colors.amber.shade200,
            padding: EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tài khoản: test_account'),
                Text('Mật khẩu: password123'),
                Text('Mã kích hoạt: pa2qrfqafhQgaitgATGQGa'),
                Text('Link kích hoạt: https://anylearn.com/test'),
              ],
            )
          ),
          Text('Lịch học:',style: style,),
          Container(
            color: Colors.amber.shade200,
            padding: EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Thứ 1: 21h - 23h'),
                Text('Thứ 1: 21h - 23h'),
                Text('Thứ 1: 21h - 23h'),
              ],
            )
          ),
    
          Text('Hướng đẫn sử dụng: https://anylearn.com/hdsd', style: style),
        ],
      ),
    );
  }
}