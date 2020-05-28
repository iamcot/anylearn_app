import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final function;
  final String title;
  final double height;

  const GradientButton({Key key, this.function, this.title, this.height: 40.0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent, Colors.blue]),
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: height,
      child: FlatButton(
          onPressed: () {
            function();
          },
          child: Text(
            title,
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          )),
    );
  }
}
