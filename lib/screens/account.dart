import 'package:anylearn/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import '../dto/user_dto.dart';
import 'account/account_body.dart';
import 'loading.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserDTO user;
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return BlocProvider.of<AuthBloc>(context);
        },
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailState) {
              Navigator.of(context).popAndPushNamed("/login");
            }
            if (state is AuthSuccessState) {
              user = state.user;
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthFailState) {
                return LoginScreen();
              }
              if (state is AuthSuccessState) {
                user = state.user;
              }
              return user != null ? AccountBody(user: user) : LoadingScreen();
            },
          ),
        ),
      ),
    );
  }
}
