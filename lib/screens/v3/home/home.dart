import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/home/home_bloc.dart';
import '../../../dto/user_dto.dart';
import '../../../dto/v3/home_dto.dart';
import '../../../main.dart';
import '../../../models/page_repo.dart';
import '../../../widgets/bottom_nav.dart';
import '../../home/exit_confirm.dart';
import '../../loading.dart';
import 'body.dart';
import 'search_box.dart';

class V3HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _V3HomeScreen();
}

class _V3HomeScreen extends State<V3HomeScreen> {
  late AuthBloc _authBloc;
  late HomeBloc _homeBloc;
  //late String _role;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    _homeBloc = HomeBloc(pageRepository: pageRepo);
    // checkFirstSeen();
  }

  HomeV3DTO? homeData;
  Future<bool> _willExit() async {
    return await showDialog(context: context, builder: (context) => new ExitConfirm());
  }

  final searchController = TextEditingController();

  Timer? _debounce;
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
  // Future checkFirstSeen() async {
  //   int version = 12;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int _seen = (prefs.getInt('intro_seen') ?? version);

  //   if (_seen <= version) {
  //     await prefs.setInt('intro_seen', version + 1);
  //     setState(() {
  //       V3canShowPopup = false;
  //     });
  //     // Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new IntroScreen()));
  //   }
  // }

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
              debugPrint("reload home");
              _homeBloc..add(LoadHomeEvent(user: user));
            }

            return BlocProvider<HomeBloc>(
              create: (context) => _homeBloc,
              child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                if (state is HomeSuccessState) {
                  homeData = state.data;
                }
                if (state is HomeFailState) {
                  return Scaffold(
                    body: Container(alignment: Alignment.center, child: Text(state.error.toString())),
                  );
                }
                return homeData == null
                    ? LoadingScreen()
                    : Scaffold(
                        appBar: PreferredSize(
                          preferredSize: Size.fromHeight(100.0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.blue,
                                  Colors.white, //@TODO change to white later
                                ],
                                stops: [0.7, 0.3],
                              ),
                            ),
                            child: Container(
                              // height: 100.0,
                              margin: EdgeInsets.fromLTRB(15, 80.0, 15, 10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    padding: EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey, width: 0)
                                        ),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed("/qrcode");
                                      },
                                      icon: Icon(
                                        Icons.qr_code_scanner,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10.0),
                                      height: 50.0,
                                      child: SearchBox(user: user),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        body: RefreshIndicator(
                          child: V3HomeBody(
                              user: user,
                              homeData: homeData!,
                              homeBloc: _homeBloc,
                              ),
                          onRefresh: _reloadPage,
                        ),
                        bottomNavigationBar: BottomNav(BottomNav.HOME_INDEX),
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
