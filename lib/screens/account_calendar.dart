import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/account/account_blocs.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_blocs.dart';
import '../dto/account_calendar_dto.dart';
import '../dto/user_dto.dart';
import '../models/user_repo.dart';
import '../widgets/loading_widget.dart';
import 'account/account_calendar_list.dart';

class AccountCalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountCalendarScreen();
}

class _AccountCalendarScreen extends State<AccountCalendarScreen> with TickerProviderStateMixin {
  AccountCalendarDTO calendars;

  bool createdTab = false;
  TabController _tabController;
  AccountBloc _accountBloc;
  AuthBloc _authBloc;
  UserDTO _user;

  @override
  void didChangeDependencies() {
    final userRepo = RepositoryProvider.of<UserRepository>(context);
    _accountBloc = AccountBloc(userRepository: userRepo);
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is AuthFailState) {
          Navigator.of(context).popUntil(ModalRoute.withName("/"));
          Navigator.of(context).pushNamed("/login");
        }
        if (state is AuthSuccessState) {
          _user = state.user;
          _accountBloc..add(AccLoadMyCalendarEvent(token: _user.token));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Lịch học của tôi"),
          bottom: PreferredSize(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 120.0,
                  child: Image.asset("assets/banners/schedule_banner.jpg", fit: BoxFit.cover),
                ),
                TabBar(controller: _tabController, tabs: [
                  Tab(child: Text("Đã qua")),
                  Tab(child: Text("Sắp diễn ra")),
                ]),
              ],
            ),
            preferredSize: Size.fromHeight(150.0),
          ),
        ),
        body: BlocProvider<AccountBloc>(
          create: (context) => _accountBloc,
          child: BlocListener<AccountBloc, AccountState>(
            listener: (context, state) {
              if (state is AccJoinSuccessState) {
                Scaffold.of(context).showSnackBar(new SnackBar(content: Text("Xác nhận thành công")));
              }  
              if (state is AccountFailState) {
                  Scaffold.of(context).showSnackBar(new SnackBar(content: Text(state.error)));
              }
            },
            child: BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                if (state is AccMyCalendarSuccessState) {
                  calendars = state.calendar;
                }
                print(calendars);
                return TabBarView(
                  controller: _tabController,
                  children: [
                    calendars != null
                        ? AccountCalendarList(
                            events: calendars.done,
                            isOpen: false,
                            user: _user,
                          )
                        : LoadingWidget(),
                    calendars != null
                        ? AccountCalendarList(
                            events: calendars.open,
                            isOpen: true,
                            user: _user,
                          )
                        : LoadingWidget(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
