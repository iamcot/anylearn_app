import 'package:anylearn/screens/account.dart';
import 'package:anylearn/screens/ask.dart';
import 'package:anylearn/screens/developing.dart';
import 'package:anylearn/screens/event.dart';
import 'package:anylearn/screens/home.dart';
import 'package:anylearn/screens/items.dart';
import 'package:anylearn/screens/notification.dart';
import 'package:anylearn/screens/pdp.dart';
import 'package:anylearn/screens/school.dart';
import 'package:anylearn/screens/search.dart';
import 'package:anylearn/screens/teacher.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomeScreen(),
  "/school": (BuildContext context) => SchoolScreen(),
  "/teacher": (BuildContext context) => TeacherScreen(),
  "/event": (BuildContext context) => EventScreen(),
  "/ask": (BuildContext context) => AskScreen(),
  "/account": (BuildContext context) => AccountScreen(),
  "/account/deposit": (BuildContext context) => DevelopingScreen(),
  "/account/withdraw": (BuildContext context) => DevelopingScreen(),
  "/account/commission": (BuildContext context) => DevelopingScreen(),
  "/account/transaction": (BuildContext context) => DevelopingScreen(),
  "/search": (BuildContext context) => SearchScreen(),
  "/developing": (BuildContext context) => DevelopingScreen(),
  "/notification": (BuildContext context) => NotificationScreen(),
  "/items": (BuildContext context) => ItemsScreen(),
  "/pdp": (BuildContext context) => PDPScreen(),
};
