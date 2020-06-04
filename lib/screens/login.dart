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
  @override
  void didChangeDependencies() {
    final userRepository = RepositoryProvider.of<UserRepository>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    _loginBloc = LoginBloc(userRepository: userRepository, authBloc: _authBloc);
    super.didChangeDependencies();
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
          }

          if (!noticeShow) {
            if (ModalRoute.of(context).settings.arguments != null) {
              Scaffold.of(context).showSnackBar(new SnackBar(
                content: Text(ModalRoute.of(context).settings.arguments.toString()),
              ));
              noticeShow = true;
            }
          }
        },
        child: BlocProvider(
          create: (context) {
            return _loginBloc;
          },
          child: LoginForm(loginBloc: _loginBloc),
        ),
      ),
    );
  }
}
