import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';
import '../dto/user_dto.dart';
import 'account/account_body.dart';
import 'loading.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountScreen();
}

class _AccountScreen extends State<AccountScreen> {
  UserDTO user;

  @override
  Widget build(BuildContext context) {
    final _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is AuthFailState) {
          Navigator.of(context).popAndPushNamed("/login");
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccessState) {
            user = state.user;
          }
          return Scaffold(
            body: user != null
                ? AccountBody(
                    user: user,
                    authBloc: _authBloc,
                  )
                : LoadingScreen(),
          );
        },
      ),
    );
  }
}
