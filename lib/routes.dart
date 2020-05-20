import 'package:anylearn/screens/account.dart';
import 'package:anylearn/screens/ask.dart';
import 'package:anylearn/screens/ask_cat.dart';
import 'package:anylearn/screens/developing.dart';
import 'package:anylearn/screens/event.dart';
import 'package:anylearn/screens/home.dart';
import 'package:anylearn/screens/items.dart';
import 'package:anylearn/screens/notification.dart';
import 'package:anylearn/screens/pdp.dart';
import 'package:anylearn/screens/qrcode.dart';
import 'package:anylearn/screens/school.dart';
import 'package:anylearn/screens/teacher.dart';
import 'package:flutter/widgets.dart';

import 'screens/qrcode_scan.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomeScreen(),
  "/school": (BuildContext context) => SchoolScreen(),
  "/teacher": (BuildContext context) => TeacherScreen(),
  "/event": (BuildContext context) => EventScreen(),
  "/ask": (BuildContext context) => AskScreen(),
  "/ask/cat": (BuildContext context) => AskCatScreen(),
  "/account": (BuildContext context) => AccountScreen(),
  "/account/deposit": (BuildContext context) => DevelopingScreen(),
  "/account/withdraw": (BuildContext context) => DevelopingScreen(),
  "/account/commission": (BuildContext context) => DevelopingScreen(),
  "/account/transaction": (BuildContext context) => DevelopingScreen(),
  "/developing": (BuildContext context) => DevelopingScreen(),
  "/notification": (BuildContext context) => NotificationScreen(),
  "/items": (BuildContext context) => ItemsScreen(),
  "/pdp": (BuildContext context) => PDPScreen(),
  "/qrcode": (BuildContext context) => QrCodeScreen(),
};
