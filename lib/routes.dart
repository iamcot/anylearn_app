import 'package:anylearn/screens/account.dart';
import 'package:anylearn/screens/ask.dart';
import 'package:anylearn/screens/event.dart';
import 'package:anylearn/screens/home.dart';
import 'package:anylearn/screens/school.dart';
import 'package:anylearn/screens/teacher.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomeScreen(),
  "/school": (BuildContext context) => SchoolScreen(),
  "/teacher": (BuildContext context) => TeacherScreen(),
  "/event": (BuildContext context) => EventScreen(),
  "/ask": (BuildContext context) => AskScreen(),
  "/account": (BuildContext context) => AccountScreen(),
};
