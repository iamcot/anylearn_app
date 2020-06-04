import '../dto/account_calendar_dto.dart';
import '../dto/event_dto.dart';
import 'account/account_calendar_list.dart';
import 'package:flutter/material.dart';

class AccountCalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountCalendarScreen();
}

class _AccountCalendarScreen extends State<AccountCalendarScreen> with TickerProviderStateMixin {
  final AccountCalendarDTO calendars = AccountCalendarDTO(done: [
    // EventDTO(
    //   date: "2020-05-10",
    //   time: "09:00",
    //   title: "Khóa học làm giàu",
    //   content: "Giới thiệu về buổi học",
    //   route: "/pdp",
    //   userName: "Thầy giáo X",
    // ),
  ], thisMonth: [
    EventDTO(
      date: "2020-04-10",
      time: "09:00",
      title: "Khóa học làm giàu 1",
      content: "Giới thiệu về buổi học",
      route: "/pdp",
      author: "Thầy giáo X",
    ),
  ]);

  bool createdTab = false;
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (!createdTab) {
        createdTab = true;
        _tabController = new TabController(vsync: this, length: 3, initialIndex: 1);
      }
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Lịch học của tôi"),
        bottom:
            /*PreferredSize(
          child: Column(children: <Widget>[
            Container(
              width: double.infinity,
              height: 120.0,
              child: Image.asset("assets/banners/schedule_banner.jpg", fit: BoxFit.cover),
            ), */
            TabBar(controller: _tabController, tabs: [
          Tab(child: Text("Đã tham gia")),
          Tab(child: Text("Tháng " + DateTime.now().month.toString())),
          Tab(child: Text("Sắp tới")),
        ]),
        // ],
        // ),
        // preferredSize: Size.fromHeight(150.0),
        // ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AccountCalendarList(events: calendars.done),
          AccountCalendarList(events: calendars.thisMonth),
          AccountCalendarList(events: calendars.later),
        ],
      ),
    );
  }
}
