import 'package:anylearn/dto/user_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/auth/auth_blocs.dart';
import '../blocs/home/home_blocs.dart';
import '../customs/feedback.dart';
import '../dto/home_dto.dart';
import '../dto/quote_dto.dart';
import '../main.dart';
import '../models/page_repo.dart';
import '../widgets/appbar.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/fab_home.dart';
import '../widgets/intro.dart';
import 'home/exit_confirm.dart';
import 'home/home_body.dart';
import 'loading.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  late AuthBloc _authBloc;
  late HomeBloc _homeBloc;
  late QuoteDTO _quote;
  late String _role;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    _homeBloc = HomeBloc(pageRepository: pageRepo);
    checkFirstSeen();
  }

  HomeDTO? homeData;
  Future<bool> _willExit() async {
    return await showDialog(
        context: context, builder: (context) => new ExitConfirm());
  }

  Future checkFirstSeen() async {
    int version = 9;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int _seen = (prefs.getInt('intro_seen') ?? version);

    // if (_seen <= version) {
      await prefs.setInt('intro_seen', version + 1);
      setState(() {
        canShowPopup = false;
      });
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (context) => new IntroScreen()));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _willExit,
        child: BlocBuilder<AuthBloc, AuthState>(
          bloc: _authBloc,
          builder: (context, state) {
            if (state is AuthSuccessState) {
              user = state.user;
              _homeBloc.add(LoadHomeEvent(user: user));
            }
            if (state is AuthFailState) {
              user = UserDTO(id: 0, token: "");
              print("reload home");
              _homeBloc..add(LoadHomeEvent(user: user));
            }

            return BlocProvider<HomeBloc>(
              create: (context) =>
                  _homeBloc, //..add(LoadHomeEvent(role: _role)),
              child:
                  BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                if (state is HomeSuccessState) {
                  homeData = state.data;
                  _homeBloc
                    ..add(LoadQuoteEvent(url: homeData?.config.quoteUrl));
                }
                return homeData == null
                    ? LoadingScreen()
                    : Scaffold(
                        appBar: BaseAppBar(
                          screen: "home",
                          user: user,
                          hasBack: false,
                          title: "",
                        ),
                        body: RefreshIndicator(
                          child: CustomFeedback(
                              user: user,
                              child: HomeBody(
                                user: user,
                                homeData: homeData!,
                                homeBloc: _homeBloc,
                              )),
                          onRefresh: _reloadPage,
                        ),
                        floatingActionButton: FloatingActionButtonHome(
                          isHome: true,
                        ),
                        floatingActionButtonLocation:
                            FloatingActionButtonLocation.startDocked,
                        bottomNavigationBar: BottomNav(
                          route: BottomNav.HOME_INDEX,
                        ),
                      );
              }),
            );
          },
        ));
  }

  Future<void> _reloadPage() async {
    _homeBloc..add(LoadHomeEvent(user: user));
  }
}
