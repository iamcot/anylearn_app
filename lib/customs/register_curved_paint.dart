import 'package:flutter/material.dart';

class CustomCurvedPaint extends CustomPainter {
  Color colorOne = Colors.blue;
  Color colorThree = Colors.blue[100];

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.lineTo(0, size.height * 0.95);
    path.quadraticBezierTo(size.width * 0.15, size.height * 0.95, size.width * 0.5, size.height * 0.60);
    path.quadraticBezierTo(size.width * 0.60, size.height * 0.50, size.width * 0.65, size.height * 0.47);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.40, size.width * 0.85, size.height * 0.45);
    path.quadraticBezierTo(size.width * 0.95, size.height * 0.55, size.width, size.height * 0.7);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = colorThree;
    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, size.height * 0.65);
    path.quadraticBezierTo(size.width * 0.15, size.height * 0.80, size.width * 0.5, size.height * 0.50);
    path.quadraticBezierTo(size.width * 0.60, size.height * 0.40, size.width * 0.65, size.height * 0.37);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.30, size.width * 0.85, size.height * 0.35);
    path.quadraticBezierTo(size.width * 0.95, size.height * 0.45, size.width, size.height * 0.6);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = colorOne;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
