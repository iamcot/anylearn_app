import 'package:flutter/material.dart';

class ExitConfirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text('Xác nhận!'),
      content: new Text('Bạn có chắc là muốn thoát và đóng Ứng dụng?'),
      actions: <Widget>[
        new FlatButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: new Text('Thoát'),
        ),
        new RaisedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: new Text('Ở lại'),
        ),
      ],
    );
  }
}
