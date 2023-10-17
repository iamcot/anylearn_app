import 'package:anylearn/screens/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../main.dart';
import 'account/account_body.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountScreen();
}

class _AccountScreen extends State<AccountScreen> {
  late AuthBloc _authBloc;

  @override
  void didChangeDependencies() {
    if (user.token == "") {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).popAndPushNamed("/login");
      });
    }

    _authBloc = BlocProvider.of<AuthBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is AuthFailState) {
          Navigator.of(context).popAndPushNamed("/login");
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        bloc: _authBloc,
        builder: (context, state) {
          if (state is AuthSuccessState) {
            user = state.user;
          }

          return user.token == ""
              ? LoadingScreen()
              : Scaffold(
                  body: AccountBody(
                  authBloc: _authBloc,
                ));
        },
      ),
    );
  }
}
