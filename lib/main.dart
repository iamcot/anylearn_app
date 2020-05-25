import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth/auth_bloc.dart';
import 'models/page_repo.dart';
import 'models/user_repo.dart';
import 'routes.dart';
import 'screens/home.dart';
import 'themes/default.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepo = UserRepository();
  final pageRepo = PageRepository();
  return runApp(
    MultiRepositoryProvider(providers: [
      RepositoryProvider<UserRepository>(
        create: (context) => userRepo,
      ),
      RepositoryProvider<PageRepository>(
        create: (context) => pageRepo,
      ),
    ], child: BlocProvider<AuthBloc>(create: (context) => AuthBloc(userRepository: userRepo), child: MyApp())),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
