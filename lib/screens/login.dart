import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/login/login_bloc.dart';
import '../models/user_repo.dart';
import 'login/login_form.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository = new UserRepository();

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
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authBloc: BlocProvider.of<AuthBloc>(context),
            userRepository: userRepository,
          );
        },
        child: LoginForm(),
      ),
    );
  }
}
