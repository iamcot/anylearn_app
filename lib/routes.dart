import 'package:flutter/widgets.dart';

import 'screens/account.dart';
import 'screens/account_about.dart';
import 'screens/account_calendar.dart';
import 'screens/account_contact.dart';
import 'screens/account_edit.dart';
import 'screens/account_friends.dart';
import 'screens/account_helpcenter.dart';
import 'screens/account_password.dart';
import 'screens/ask.dart';
import 'screens/ask_cat.dart';
import 'screens/deposit.dart';
import 'screens/developing.dart';
import 'screens/event.dart';
import 'screens/exchange.dart';
import 'screens/items_school.dart';
import 'screens/items_teacher.dart';
import 'screens/login.dart';
import 'screens/notification.dart';
import 'screens/pdp.dart';
import 'screens/qrcode.dart';
import 'screens/register.dart';
import 'screens/school.dart';
import 'screens/teacher.dart';
import 'screens/transaction.dart';
import 'screens/withdraw.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  // "/": (BuildContext context) => HomeScreen(),
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
  "/deposit": (BuildContext context) => DepositScreen(),
  "/withdraw": (BuildContext context) => WithdrawScreen(),
  "/exchange": (BuildContext context) => ExchangeScreen(),
  "/transaction": (BuildContext context) => TransactionScreen(),
  "/developing": (BuildContext context) => DevelopingScreen(),
  "/notification": (BuildContext context) => NotificationScreen(),
  "/items/teacher": (BuildContext context) => ItemsTeacherScreen(),
  "/items/school": (BuildContext context) => ItemsSchoolScreen(),
  "/pdp": (BuildContext context) => PDPScreen(),
  "/qrcode": (BuildContext context) => QrCodeScreen(),
  "/register": (BuildContext context) => RegisterScreen(),
  "/login": (BuildContext context) => LoginScreen(),
};
