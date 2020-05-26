import 'package:anylearn/dto/const.dart';
import 'package:anylearn/screens/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_blocs.dart';
import '../blocs/home/home_blocs.dart';
import '../dto/user_dto.dart';
import '../models/page_repo.dart';
import '../widgets/bottom_nav.dart';
import 'home/exit_confirm.dart';
import 'home/home_body.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  AuthBloc _authBloc;
  HomeBloc _homeBloc;
  @override
  void didChangeDependencies() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _authBloc.add(AuthCheckEvent());
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    _homeBloc = HomeBloc(pageRepository: pageRepo);
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
              _homeBloc..add(LoadHomeEvent(role: state.user.role));
            }
            if (state is AuthFailState) {
              user = null;
              _homeBloc..add(LoadHomeEvent(role: MyConst.ROLE_GUEST));
            }
            return BlocProvider<HomeBloc>(
              create: (context) => _homeBloc,
              child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                if (state is HomeSuccessState) {
                  return HomeBody(user: user, homeData: state.data);
                }
                return LoadingScreen();
              }),
            );
          },
        ),
        bottomNavigationBar: BottomNav(
          index: BottomNav.HOME_INDEX,
        ),
      ),
    );
  }
}
