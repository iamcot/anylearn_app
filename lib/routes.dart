import 'package:anylearn/screens/account.dart';
import 'package:anylearn/screens/account_about.dart';
import 'package:anylearn/screens/account_calendar.dart';
import 'package:anylearn/screens/account_contact.dart';
import 'package:anylearn/screens/account_edit.dart';
import 'package:anylearn/screens/account_friends.dart';
import 'package:anylearn/screens/account_helpcenter.dart';
import 'package:anylearn/screens/account_password.dart';
import 'package:anylearn/screens/account_transaction.dart';
import 'package:anylearn/screens/ask.dart';
import 'package:anylearn/screens/ask_cat.dart';
import 'package:anylearn/screens/developing.dart';
import 'package:anylearn/screens/event.dart';
import 'package:anylearn/screens/home.dart';
import 'package:anylearn/screens/items.dart';
import 'package:anylearn/screens/login.dart';
import 'package:anylearn/screens/notification.dart';
import 'package:anylearn/screens/pdp.dart';
import 'package:anylearn/screens/qrcode.dart';
import 'package:anylearn/screens/register.dart';
import 'package:anylearn/screens/school.dart';
import 'package:anylearn/screens/teacher.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomeScreen(),
  "/school": (BuildContext context) => SchoolScreen(),
  "/teacher": (BuildContext context) => TeacherScreen(),
  "/event": (BuildContext context) => EventScreen(),
  "/ask": (BuildContext context) => AskScreen(),
  "/ask/cat": (BuildContext context) => AskCatScreen(),
  "/account": (BuildContext context) => AccountScreen(),
  "/account/friends": (BuildContext context) => AccountFriendsScreen(),
  "/account/calendar": (BuildContext context) => AccountCalendarScreen(),
  "/account/helpcenter": (BuildContext context) => AccountHelpCenterScreen(),
  "/account/about": (BuildContext context) => AccountAboutScreen(),
  "/account/edit": (BuildContext context) => AccountEditScreen(),
  "/account/password": (BuildContext context) => AccountPasswordScreen(),
  "/account/contact": (BuildContext context) => AccountContactScreen(),
  "/account/deposit": (BuildContext context) => DevelopingScreen(),
  "/account/withdraw": (BuildContext context) => DevelopingScreen(),
  "/account/commission": (BuildContext context) => DevelopingScreen(),
  "/account/transaction": (BuildContext context) => AccountTransactionScreen(),
  "/developing": (BuildContext context) => DevelopingScreen(),
  "/notification": (BuildContext context) => NotificationScreen(),
  "/items": (BuildContext context) => ItemsScreen(),
  "/pdp": (BuildContext context) => PDPScreen(),
  "/qrcode": (BuildContext context) => QrCodeScreen(),
  "/register": (BuildContext context) => RegisterScreen(),
  "/login": (BuildContext context) => LoginScreen(),
};
