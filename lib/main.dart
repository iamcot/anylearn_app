import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'app_config.dart';
import 'blocs/account/account_bloc.dart';
import 'blocs/article/article_bloc.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/course/course_bloc.dart';
import 'blocs/listing/listing_bloc.dart';
import 'blocs/notif/notif_bloc.dart';
import 'blocs/search/search_bloc.dart';
import 'dto/notification_dto.dart';
import 'dto/user_dto.dart';
import 'firebase_options.dart';
import 'models/item_repo.dart';
import 'models/page_repo.dart';
import 'models/transaction_repo.dart';
import 'models/user_repo.dart';
import 'routes.dart';
import 'screens/v3/home/home.dart';
import 'themes/default.dart';

bool newNotification = false;
String notifToken = "";
late AppConfig config;
late PackageInfo packageInfo;
String locale = "vi";
UserDTO user = UserDTO(id: 0, token: "");

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  print('Handling a background message ${message.messageId}');
}

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }

  /// Update the iOS foreground notification presentation options to allow
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  final notifObj = NotificationDTO.fromFireBase(message);
  showSimpleNotification(
      Card(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Text(
            notifObj.content,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      background: Colors.transparent);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized();
  //@TODO: pls copy new env.json file from example.json in assets/config
  config = await AppConfig.forEnv();
  packageInfo = await PackageInfo.fromPlatform();

  final userRepo = UserRepository(config: config);
  final pageRepo = PageRepository(config: config);
  final transRepo = TransactionRepository(config: config);
  final itemRepo = ItemRepository(config: config);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  return runApp(
    EasyLocalization(
      child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<UserRepository>(
              create: (context) => userRepo,
            ),
            RepositoryProvider<PageRepository>(
              create: (context) => pageRepo,
            ),
            RepositoryProvider<TransactionRepository>(
              create: (context) => transRepo,
            ),
            RepositoryProvider<ItemRepository>(
              create: (context) => itemRepo,
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(
                  create: (context) => AuthBloc(userRepository: userRepo)),
              BlocProvider<AccountBloc>(
                  create: (context) => AccountBloc(userRepository: userRepo)),
              BlocProvider<CourseBloc>(
                  create: (context) => CourseBloc(
                      itemRepository: itemRepo, userRepository: userRepo)),
              BlocProvider<SearchBloc>(
                  create: (context) => SearchBloc(pageRepository: pageRepo)),
              BlocProvider<NotifBloc>(
                  create: (context) => NotifBloc(userRepository: userRepo)),
              BlocProvider<ArticleBloc>(
                  create: (context) => ArticleBloc(pageRepository: pageRepo)),
              BlocProvider<ListingBloc>(
                  create: (context) => ListingBloc(pageRepository: pageRepo)),
            ],
            child: MyApp(),
          )),
      supportedLocales: [Locale('en'), Locale('vi')],
      path: 'assets/translations',
      saveLocale: true,
      useOnlyLangCode: true,
      // startLocale: Locale(locale),
      fallbackLocale: Locale('vi'),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((value) => print(value?.data.toString()));

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('A new onMessage event was published!');
      showFlutterNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
    // if (Platform.isIOS) {
    //   FirebaseMessaging.instance.getAPNSToken().then((token) {
    //     print("IOS apns token:");
    //     print(token);
    //     notifToken = token!;
    //   });
    // } else {
    FirebaseMessaging.instance.getToken().then((token) {
      print(token);
      notifToken = token!;
    });
    // }
  }

  @override
  void didChangeDependencies() {
    locale = context.locale.languageCode;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(context.locale.toString());
    return OverlaySupport(
      child: MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        ),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'anyLearn',
        theme: appTheme(),
        routes: routes,
        home: V3HomeScreen(),
        // home: HomeScreen(),
      ),
    );
  }
}
