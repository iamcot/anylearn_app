import 'package:anylearn/main.dart';
import 'package:anylearn/screens/rating_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/account/account_blocs.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_blocs.dart';
import '../dto/account_calendar_dto.dart';
import '../dto/user_dto.dart';
import '../models/user_repo.dart';
import '../widgets/calendar_box.dart';
import '../widgets/loading_widget.dart';
import 'account/account_calendar_list.dart';

class AccountCalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountCalendarScreen();
}

class _AccountCalendarScreen extends State<AccountCalendarScreen> with TickerProviderStateMixin {
  AccountCalendarDTO? calendars;

  bool createdTab = false;
  late TabController _tabController;
  late AccountBloc _accountBloc;

  @override
  void didChangeDependencies() {
    if (user.token == "") {
      Navigator.of(context).popAndPushNamed("/login");
    }
    final userRepo = RepositoryProvider.of<UserRepository>(context);
    _accountBloc = AccountBloc(userRepository: userRepo)..add(AccLoadMyCalendarEvent(token: user.token));
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Tab(child: Text("Quan tâm")),
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
              // Scaffold.of(context).showSnackBar(new SnackBar(content: Text("Xác nhận thành công")));
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("Mời đánh giá khóa học."),
                        content: Text("Chúc mừng bạn vừa hoàn thành buổi học. Vui lòng để lại đánh giá của bạn nhé."),
                        actions: [
                          FlatButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                final sentReview =
                                    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  return RatingInputScreen(
                                      user: user, itemId: state.itemId, itemTitle: "", lastRating: 0);
                                }));
                              },
                              child: Text("ĐÁNH GIÁ"))
                        ],
                      ));
            }
            if (state is AccountFailState) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state is AccMyCalendarSuccessState) {
                calendars = state.calendar;
              }
              return TabBarView(
                controller: _tabController,
                children: [
                  calendars != null
                      ? AccountCalendarList(
                          accountBloc: _accountBloc,
                          events: calendars!.done,
                          isOpen: false,
                          user: user,
                        )
                      : LoadingWidget(),
                  calendars != null
                      ? AccountCalendarList(
                          accountBloc: _accountBloc,
                          events: calendars!.open,
                          isOpen: true,
                          user: user,
                        )
                      : LoadingWidget(),
                  calendars != null
                      ? (calendars!.fav.length > 0
                          ? ListView.separated(
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: CalendarBox(
                                    fontSize: 12,
                                    text: DateFormat("dd/MM").format(DateTime.parse(calendars!.fav[index].date)),
                                    image: calendars!.fav[index].image,
                                  ),
                                  title: Text(
                                    calendars!.fav[index].title,
                                  ),
                                  trailing: Icon(Icons.chevron_right),
                                  onTap: () {
                                    Navigator.of(context).pushNamed("/pdp", arguments: calendars!.fav[index].itemId);
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider();
                              },
                              itemCount: calendars!.fav.length)
                          : Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text.rich(
                                TextSpan(
                                  text: "Bạn chưa đánh dấu khóa học nào là ưa thích.",
                                  style: TextStyle(fontSize: 16.0),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "Xem các lịch học đang có",
                                        style: TextStyle(color: Colors.blue),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(context).pushNamed("/event");
                                          }),
                                  ],
                                ),
                                textAlign: TextAlign.left,
                              )))
                      : LoadingWidget(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
