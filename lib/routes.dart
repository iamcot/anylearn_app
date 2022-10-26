import 'package:flutter/widgets.dart';

import 'screens/account.dart';
import 'screens/account/account_children.dart';
import 'screens/account_about.dart';
import 'screens/account_calendar.dart';
import 'screens/account_contact.dart';
import 'screens/account_delete.dart';
import 'screens/account_docs.dart';
import 'screens/account_edit.dart';
import 'screens/account_friends.dart';
import 'screens/account_helpcenter.dart';
import 'screens/account_password.dart';
import 'screens/account_profile.dart';
import 'screens/ask.dart';
import 'screens/ask_cat.dart';
import 'screens/ask_content.dart';
import 'screens/ask_forum.dart';
import 'screens/ask_forum_thread.dart';
import 'screens/contract_school.dart';
import 'screens/contract_sign.dart';
import 'screens/contract_teacher.dart';
import 'screens/course_form.dart';
import 'screens/course_list.dart';
import 'screens/course_registered.dart';
import 'screens/event.dart';
import 'screens/exchange.dart';
import 'screens/foundation.dart';
import 'screens/guide.dart';
import 'screens/items_school.dart';
import 'screens/items_teacher.dart';
import 'screens/locale.dart';
import 'screens/login.dart';
import 'screens/notification.dart';
import 'screens/password_reset.dart';
import 'screens/pdp.dart';
import 'screens/pendingorder/pendingorder.dart';
import 'screens/qrcode.dart';
import 'screens/register.dart';
import 'screens/school.dart';
import 'screens/teacher.dart';
import 'screens/transaction.dart';
import 'screens/withdraw.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  // "/home": (BuildContext context) => HomeScreen(),
  "/school": (BuildContext context) => SchoolScreen(),
  "/teacher": (BuildContext context) => TeacherScreen(),
  "/event": (BuildContext context) => EventScreen(),
  "/ask": (BuildContext context) => AskScreen(),
  "/article": (BuildContext context) => AskArticleScreen(),
  "/ask/cat": (BuildContext context) => AskCatScreen(),
  "/ask/forum": (BuildContext context) => AskForumScreen(),
  "/ask/forum/thread": (BuildContext context) => AskForumThreadScreen(),
  "/account": (BuildContext context) => AccountScreen(),
  "/account/friends": (BuildContext context) => AccountFriendsScreen(),
  "/account/calendar": (BuildContext context) => AccountCalendarScreen(),
  "/account/helpcenter": (BuildContext context) => AccountHelpCenterScreen(),
  "/account/about": (BuildContext context) => AccountAboutScreen(),
  "/account/edit": (BuildContext context) => AccountEditScreen(),
  "/account/password": (BuildContext context) => AccountPasswordScreen(),
  "/account/contact": (BuildContext context) => AccountContactScreen(),
  "/account/children": (BuildContext context) => AccountChildrenScreen(),
  "/withdraw": (BuildContext context) => WithdrawScreen(),
  "/exchange": (BuildContext context) => ExchangeScreen(),
  "/transaction": (BuildContext context) => TransactionScreen(),
  "/notification": (BuildContext context) => NotificationScreen(),
  "/items/teacher": (BuildContext context) => ItemsTeacherScreen(),
  "/items/school": (BuildContext context) => ItemsSchoolScreen(),
  "/pdp": (BuildContext context) => PDPScreen(),
  "/qrcode": (BuildContext context) => QrCodeScreen(),
  "/register": (BuildContext context) => RegisterScreen(),
  "/login": (BuildContext context) => LoginScreen(),
  "/course/form": (BuildContext context) => CourseFormScreen(),
  "/course/list": (BuildContext context) => CourseListScreen(),
  "/course/registered": (BuildContext context) => CourseRegisteredScreen(),
  "/foundation": (BuildContext context) => FoundationScreen(),
  "/guide": (BuildContext context) => GuideScreen(),
  "/profile": (BuildContext context) => AccountProfileScreen(),
  "/account/docs": (BuildContext context) => AccountDocsScreen(),
  "/contract/teacher": (BuildContext context) => ContractTeacherScreen(),
  "/contract/school": (BuildContext context) => ContractSchoolScreen(),
  "/contract/sign": (BuildContext context) => ContractSignScreen(),
  // "/draw": (BuildContext context) => DrawScreen(),
  "/resetPassword": (BuildContext context) => PasswordResetScreen(),
  "/account/delete": (BuildContext context) => AccountDeleteScreen(),
  // "/passwordupdate": (BuildContext context) => PasswordupdateScreen(),
  "/pendingorder/pendingorder": (BuildContext context) => PendingOrder(),
  "/locale": (BuildContext context) => LocaleScreen(),
};
