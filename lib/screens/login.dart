import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';
import '../blocs/login/login_bloc.dart';
import '../models/user_repo.dart';
import 'login/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userRepository = RepositoryProvider.of<UserRepository>(context);
    final _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    final _loginBloc = LoginBloc(userRepository: userRepository, authBloc: _authBloc);
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
            Navigator.of(context).pop();
          }
        },
        child: BlocProvider(
          create: (context) {
            return _loginBloc;
          },
          child: LoginForm(),
        ),
      ),
    );
  }
}
