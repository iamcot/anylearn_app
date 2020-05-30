import 'package:anylearn/dto/home_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_blocs.dart';
import '../blocs/home/home_blocs.dart';
import '../dto/const.dart';
import '../dto/quote_dto.dart';
import '../dto/user_dto.dart';
import '../models/page_repo.dart';
import '../widgets/bottom_nav.dart';
import 'home/exit_confirm.dart';
import 'home/home_body.dart';
import 'loading.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  AuthBloc _authBloc;
  HomeBloc _homeBloc;
  QuoteDTO _quote;
  String _role;
  @override
  void didChangeDependencies() {
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    _homeBloc = HomeBloc(pageRepository: pageRepo);
    super.didChangeDependencies();
  }

  UserDTO user;
  HomeDTO homeData;
  Future<bool> _willExit() async {
    return await showDialog(context: context, builder: (context) => new ExitConfirm());
  }

  @override
  Widget build(BuildContext context) {
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
            _homeBloc.add(LoadHomeEvent(user: user));

            return BlocProvider<HomeBloc>(
              create: (context) => _homeBloc,//..add(LoadHomeEvent(role: _role)),
              child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                if (state is HomeSuccessState) {
                  homeData = state.data;
                  _homeBloc.add(LoadQuoteEvent());
                }
                return homeData != null
                    ? RefreshIndicator(
                        child: HomeBody(user: user, homeData: homeData),
                        onRefresh: _reloadPage,
                      )
                    : LoadingScreen();
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

  Future<void> _reloadPage() async {
    _homeBloc..add(LoadHomeEvent(user: user));
  }
}
