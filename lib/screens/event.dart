import 'package:anylearn/main.dart';
import 'package:easy_localization/easy_localization.dart';
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
import 'event/day_events.dart';

class EventScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EventScreen();
}

class _EventScreen extends State<EventScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late EventBloc _eventBloc;

  late Map<DateTime, List> _events;
  List? _selectedEvents;

  @override
  void didChangeDependencies() {
    if (user.token == "") {
      Navigator.of(context).popAndPushNamed("/login");
    }
    final PageRepository pageRepository = RepositoryProvider.of<PageRepository>(context);
    _eventBloc = EventBloc(pageRepository: pageRepository);//..add(LoadEventEvent(month: DateTime.now()));
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    _selectedEvents!.clear();
    _events.clear();
    _eventBloc..add(LoadEventEvent(month: first));
  }

  @override
  Widget build(BuildContext context) {
        Text('title').tr();

    return Scaffold(
      appBar: BaseAppBar(
        title: "Lịch đào tạo & Sự kiện",
        user: user,
      ),
      body: BlocProvider<EventBloc>(
        create: (context) => _eventBloc,
        child: BlocBuilder<EventBloc, EventState>(builder: (context, state) {
          if (state is EventSuccessState) {
            _events = state.data;
            _selectedEvents = (_selectedEvents!.length > 0
                ? _selectedEvents
                : _events[DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()))])!;
          }
          return CustomFeedback(
            user: user,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTableCalendarWithBuilders(),
                // Expanded(child: _buildEventList()),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      firstDay: DateTime.utc(2022, 01, 01),
      lastDay: DateTime.utc(2022, 12, 31),
      focusedDay: DateTime.now(),
      // events: _events,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
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
          : _selectedEvents!
              .map((event) => DayEvents(
                    eventToday: event,
                  ))
              .toList(),
    );
  }
}
