import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_event.dart';
import 'blocs/auth/auth_state.dart';
import 'models/user_repo.dart';
import 'routes.dart';
import 'screens/home.dart';
import 'themes/default.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  return runApp(RepositoryProvider<UserRepository>(
    create: (context) {
      return UserRepository();
    },
    child: BlocProvider<AuthBloc>(
      create: (context) {
        final userRepository = RepositoryProvider.of<UserRepository>(context);
        return AuthBloc(userRepository: userRepository)..add(AuthStarted());
      },
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'anyLearn',
      theme: appTheme(),
      routes: routes,
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return HomeScreen();
        },
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
