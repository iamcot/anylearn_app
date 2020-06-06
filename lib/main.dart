import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
import 'themes/default.dart';

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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: child,
      ),
      debugShowCheckedModeBanner: false,
      title: 'anyLearn',
      theme: appTheme(),
      routes: routes,
      home: HomeScreen(),
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
