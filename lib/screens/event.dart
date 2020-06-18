import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_blocs.dart';
import '../blocs/event/event_bloc.dart';
import '../blocs/event/event_blocs.dart';
import '../customs/feedback.dart';
import '../dto/user_dto.dart';
import '../models/page_repo.dart';
import '../widgets/appbar.dart';
import '../widgets/bottom_nav.dart';
import 'event/day_events.dart';

class EventScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EventScreen();
}

class _EventScreen extends State<EventScreen> with TickerProviderStateMixin {
  CalendarController _calendarController;
  AnimationController _animationController;
  EventBloc _eventBloc;
  AuthBloc _authBloc;
  UserDTO _user;

  Map<DateTime, List> _events;
  List _selectedEvents;

  @override
  void didChangeDependencies() {
    final PageRepository pageRepository = RepositoryProvider.of<PageRepository>(context);
    _eventBloc = EventBloc(pageRepository: pageRepository)..add(LoadEventEvent(month: DateTime.now()));
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    _selectedEvents = null;
    _events = null;
    _eventBloc..add(LoadEventEvent(month: first));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        bloc: _authBloc,
        builder: (context, state) {
          if (state is AuthSuccessState) {
            _user = state.user;
          }

          return Scaffold(
            appBar: BaseAppBar(
              title: "Lịch đào tạo & Sự kiện",
              user: _user ?? null,
            ),
            body: BlocProvider<EventBloc>(
              create: (context) => _eventBloc,
              child: BlocBuilder<EventBloc, EventState>(builder: (context, state) {
                if (state is EventSuccessState) {
                  _events = state.data;
                  _selectedEvents =
                      _selectedEvents ?? _events[DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()))];
                }
                return CustomFeedback(
                  user: _user,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildTableCalendarWithBuilders(),
                      Expanded(child: _buildEventList()),
                    ],
                  ),
                );
              }),
            ),
            bottomNavigationBar: BottomNav(
              index: BottomNav.EVENT_INDEX,
            ),
          );
        });
  }

  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.green[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(right: 1, bottom: 1, child: _buildEventsMarker(date, events)),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.red[500]
            : _calendarController.isToday(date) ? Colors.red[500] : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents == null
          ? []
          : _selectedEvents
              .map((event) => DayEvents(
                    eventToday: event,
                  ))
              .toList(),
    );
  }
}
