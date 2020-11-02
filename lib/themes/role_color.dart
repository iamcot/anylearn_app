import 'package:flutter/material.dart';

Color roleColor(String role) {
  switch (role) {
    case "teacher":
      return Colors.orange;
    case "school":
      return Colors.blue;
    default:
      return Colors.green;
  }
}
