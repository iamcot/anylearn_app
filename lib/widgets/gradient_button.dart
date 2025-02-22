import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final function;
  final String title;
  final double height;
  final Color color;
  final Color colorSub;

  GradientButton({
    required this.function, 
    this.title = "", 
    this.height = 40.0,
    this.color = Colors.blue, 
    this.colorSub = Colors.lightBlueAccent
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient:
            LinearGradient(colors: [color , colorSub , color]),
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: height,
      child: TextButton(
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
