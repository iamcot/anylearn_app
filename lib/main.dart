import 'package:anylearn/dto/notification_dto.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import 'app_config.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_blocs.dart';
import 'blocs/course/course_blocs.dart';
import 'models/item_repo.dart';
import 'models/page_repo.dart';
import 'models/transaction_repo.dart';
import 'models/user_repo.dart';
import 'routes.dart';
import 'screens/home.dart';
import 'services/firebase_service.dart';
import 'themes/default.dart';

bool newNotification = false;
String notifToken;
void main() async {
  final env = "prod";
  WidgetsFlutterBinding.ensureInitialized();
  final config = await AppConfig.forEnv(env);
  // BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepo = UserRepository(config: config);
  final pageRepo = PageRepository(config: config);
  final transRepo = TransactionRepository(config: config);
  final itemRepo = ItemRepository(config: config);

  return runApp(
    MultiRepositoryProvider(
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
        child: MultiBlocProvider(providers: [
          BlocProvider<AuthBloc>(create: (context) => AuthBloc(userRepository: userRepo)),
          BlocProvider<CourseBloc>(create: (context) => CourseBloc(itemRepository: itemRepo, userRepository: userRepo)),
        ], child: MyApp())),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  // @override
  // void initState() {
  //   super.initState();
  //   //Needed by iOS only
  //   _firebaseMessaging
  //       .requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));
  //   _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {});

  //   _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       final notifObj = NotificationDTO.fromFireBase(message);
  //       print("onMessage: $message");
  //       showOverlayNotification((context) {
  //         return SlideDismissible(
  //           enable: true,
  //           key: ValueKey(widget.key),
  //           child: Material(
  //             color: Colors.transparent,
  //             child: SafeArea(
  //                 bottom: false,
  //                 top: true,
  //                 child: Container(
  //                   margin: EdgeInsets.all(8),
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.all(Radius.circular(10)),
  //                       color: Colors.white,
  //                       border: Border.all(
  //                         color: Colors.grey[400],
  //                       )),
  //                   child: ListTile(
  //                     title: Text(notifObj.content),
  //                     onTap: () {
  //                       OverlaySupportEntry.of(context).dismiss();
  //                       _navigate(notifObj);
  //                     },
  //                     trailing: Builder(builder: (context) {
  //                       return IconButton(
  //                           onPressed: () {
  //                             OverlaySupportEntry.of(context).dismiss();
  //                           },
  //                           icon: Icon(Icons.close));
  //                     }),
  //                   ),
  //                 )),
  //           ),
  //         );
  //       }, duration: Duration.zero);

  //       setState(() {
  //         newNotification = true;
  //       });
  //     },
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print("onLaunch: $message");
  //       final notifObj = NotificationDTO.fromFireBase(message);
  //       _navigate(notifObj);
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       print("onResume: $message");
  //       final notifObj = NotificationDTO.fromFireBase(message);
  //       _navigate(notifObj);
  //     },
  //   );

  //   //Getting the token from FCM
  //   _firebaseMessaging.getToken().then((String token) {
  //     assert(token != null);
  //     print(token);
  //     notifToken = token;
  //   });
  // }

  // void _navigate(NotificationDTO notifObj) {
  //   if (notifObj.route != null) {
  //     navigatorKey.currentState.pushNamed(notifObj.route, arguments: notifObj.extraContent ?? null);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    FirebaseService(
        key: widget.key,
        navigatorKey: navigatorKey,
        func: () {
          setState(() {
            newNotification = true;
          });
        }).init(context);
    return OverlaySupport(
      child: MaterialApp(
        builder: (BuildContext context, Widget child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child,
        ),
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'anyLearn',
        theme: appTheme(),
        routes: routes,
        home: HomeScreen(),
      ),
    );
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}
