import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/login/login_bloc.dart';
import '../dto/login_callback.dart';
import '../main.dart';
import '../models/user_repo.dart';
import 'login/login_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  late LoginBloc _loginBloc;
  late AuthBloc _authBloc;
  bool noticeShow = false;
  LoginCallback? callback;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userRepository = RepositoryProvider.of<UserRepository>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _loginBloc = LoginBloc(userRepository: userRepository, authBloc: _authBloc);

    if (ModalRoute.of(context)?.settings.arguments != null) {
      callback = ModalRoute.of(context)?.settings.arguments as LoginCallback;
    }
    Future.delayed(Duration.zero, () {
      if (user.token != "") {
        Navigator.of(context).popUntil(ModalRoute.withName("/"));
        if (callback != null && callback!.routeName != "") {
          Navigator.of(context).pushNamed(callback!.routeName, arguments: callback!.routeArgs);
        }
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (callback != null && !noticeShow && callback!.message != "") {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(callback!.message),
          ));
        noticeShow = true;
      }
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          "assets/images/logo_text.png",
          height: 40.0,
        ),
        elevation: 0.0,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is AuthSuccessState) {
            Navigator.of(context).popUntil(ModalRoute.withName("/"));
            if (callback != null && callback!.routeName != "") {
              Navigator.of(context).pushNamed(callback!.routeName, arguments: callback!.routeArgs);
            }
          }
        },
        child: BlocProvider(
          create: (context) {
            return _loginBloc;
          },
          child: LoginForm(
            loginBloc: _loginBloc,
            callback: callback,
          ),
        ),
      ),
    );
  }
}
