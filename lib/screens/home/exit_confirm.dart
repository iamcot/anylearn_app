import 'package:flutter/material.dart';

class ExitConfirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text('Xác nhận!'),
      content: new Text('Bạn có chắc là muốn thoát và đóng Ứng dụng?'),
      actions: <Widget>[
        new TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: new Text('Thoát'),
        ),
        new TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          onPressed: () => Navigator.of(context).pop(false),
          child: new Text(
            'Ở lại',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
