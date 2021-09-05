import 'package:anylearn/dto/login_callback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_blocs.dart';
import '../blocs/login/login_bloc.dart';
import '../models/user_repo.dart';
import 'login/login_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  LoginBloc _loginBloc;
  AuthBloc _authBloc;
  bool noticeShow = false;
  LoginCallback callback;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userRepository = RepositoryProvider.of<UserRepository>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    _loginBloc = LoginBloc(userRepository: userRepository, authBloc: _authBloc);
    if (ModalRoute.of(context).settings.arguments != null) {
      callback = ModalRoute.of(context).settings.arguments;
    }
  }

  @override
  Widget build(BuildContext context) {
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
            if (callback!= null && callback.routeName != null) {
              Navigator.of(context).pushNamed(callback.routeName, arguments: callback.routeArgs);
            }
          }

          if (!noticeShow && callback != null && callback.message != null) {
             ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(callback.message),
              ));
            noticeShow = true;
          }
        },
        child: BlocProvider(
          create: (context) {
            return _loginBloc;
          },
          child: LoginForm(loginBloc: _loginBloc, callback: callback,),
        ),
      ),
    );
  }
}
