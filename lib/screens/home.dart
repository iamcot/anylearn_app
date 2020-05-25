import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_blocs.dart';
import '../dto/user_dto.dart';
import '../widgets/bottom_nav.dart';
import 'home/exit_confirm.dart';
import 'home/home_body.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  AuthBloc _authBloc;
  @override
  void didChangeDependencies() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _authBloc.add(AuthCheckEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _willExit() async {
      return await showDialog(context: context, builder: (context) => new ExitConfirm());
    }
    UserDTO user;
    return WillPopScope(
      onWillPop: _willExit,
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          bloc: _authBloc,
          builder: (context, state) {
            if (state is AuthSuccessState) {
              user = state.user;
            }
            if (state is AuthFailState) {
              user = null;
            }
            return HomeBody(user: user);
          },
        ),
        bottomNavigationBar: BottomNav(
          index: BottomNav.HOME_INDEX,
        ),
      ),
    );
  }
}
