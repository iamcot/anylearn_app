import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import '../dto/user_dto.dart';
import '../widgets/bottom_nav.dart';
import 'home/exit_confirm.dart';
import 'home/home_body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<bool> _willExit() async {
      return await showDialog(context: context, builder: (context) => new ExitConfirm());
    }

    UserDTO user;
    return new WillPopScope(
        onWillPop: _willExit,
        child: Scaffold(
          body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccessState) {
                user = state.user;
              }
              if (state is AuthFailState) {
                user = null;
              }
            },
            child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              if (state is AuthSuccessState) {
                user = state.user;
              }
              if (state is AuthFailState) {
                user = null;
              }
              return HomeBody(
                user: user,
              );
            }),
          ),
          bottomNavigationBar: BottomNav(
            index: BottomNav.HOME_INDEX,
          ),
        ));
  }
}
