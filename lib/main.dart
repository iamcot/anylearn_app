import 'package:anylearn/blocs/notif/notif_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import 'app_config.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_blocs.dart';
import 'blocs/course/course_blocs.dart';
import 'blocs/search/search_blocs.dart';
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
  final env = "dev";
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
          BlocProvider<SearchBloc>(create: (context) => SearchBloc(pageRepository: pageRepo)),
          BlocProvider<NotifBloc>(create: (context) => NotifBloc(userRepository: userRepo)),
        ], child: MyApp())),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
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
