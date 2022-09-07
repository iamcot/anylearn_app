import 'package:anylearn/blocs/account/account_blocs.dart';
import 'package:anylearn/dto/notification_dto.dart';
import 'package:anylearn/dto/user_dto.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import 'app_config.dart';
import 'blocs/article/article_bloc.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_blocs.dart';
import 'blocs/course/course_blocs.dart';
import 'blocs/notif/notif_blocs.dart';
import 'blocs/search/search_blocs.dart';
import 'models/item_repo.dart';
import 'models/page_repo.dart';
import 'models/transaction_repo.dart';
import 'models/user_repo.dart';
import 'routes.dart';
import 'screens/home.dart';
import 'themes/default.dart';

bool newNotification = false;
late String notifToken;
// final env = "prod";
// final env = "staging";
final env = "dev";
late AppConfig config;
UserDTO user = UserDTO(id: 0, token: "");

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  config = await AppConfig.forEnv(env);
  // BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepo = UserRepository(config: config);
  final pageRepo = PageRepository(config: config);
  final transRepo = TransactionRepository(config: config);
  final itemRepo = ItemRepository(config: config);
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
        ], child: MyApp())),
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
    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('A new onMessage event was published!');
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
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
    FirebaseMessaging.instance.getToken().then((token) {
      assert(token != null);
      print(token);
      notifToken = token!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'anyLearn',
        theme: appTheme(),
        routes: routes,
        home: HomeScreen(),
        // home: HomeScreen(),
      ),
    );
  }
}

// class Splash extends StatefulWidget {
//   @override
//   SplashState createState() => new SplashState();
// }

// class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
//   Future checkFirstSeen() async {
//     int version = 2;
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     int _seen = (prefs.getInt('intro_seen') ?? version);

//     if (_seen > version) {
//       Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => new HomeScreen()));
//     } else {
//       await prefs.setInt('intro_seen', version + 1);
//       Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => new IntroScreen()));
//     }
//   }

//   @override
//   void afterFirstLayout(BuildContext context) => checkFirstSeen();

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: new Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }

// class SimpleBlocDelegate extends BlocDelegate {
//   @override
//   void onEvent(Bloc bloc, Object event) {
//     print(event);
//     super.onEvent(bloc, event);
//   }

//   @override
//   void onTransition(Bloc bloc, Transition transition) {
//     print(transition);
//     super.onTransition(bloc, transition);
//   }

//   @override
//   void onError(Bloc bloc, Object error, StackTrace stackTrace) {
//     print(error);
//     super.onError(bloc, error, stackTrace);
//   }
// }
