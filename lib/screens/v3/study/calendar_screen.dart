import 'package:anylearn/blocs/study/study_bloc.dart';
import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/dto/v3/calendar_dto.dart';
import 'package:anylearn/models/page_repo.dart';
import 'package:anylearn/screens/loading.dart';
import 'package:anylearn/screens/v3/study/item_schedule.dart';
import 'package:anylearn/widgets/bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart'; 
import 'package:timelines/timelines.dart';

class CalendarScreen extends StatefulWidget {
  final UserDTO user;
  const CalendarScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime? _selectedDay = DateTime.now();
  DateTime? _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  late StudyBloc _studyBloc;

  @override
  void initState() {
    super.initState();
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    _studyBloc = StudyBloc(pageRepository: pageRepo);
  }

  @override
  void dispose() {
    _studyBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      bottomNavigationBar: BottomNav(BottomNav.MYCLASS_INDEX),
      body: BlocBuilder<StudyBloc, StudyState>(
        bloc: _reload(widget.user, _selectedDay!),
        builder: (context, state) {
          if (state is StudyLoadScheduleSuccessState) {
            return Container(
              margin: const EdgeInsets.only(top: 40),
              child: _buildBodyContent(context, state.data),
            );
          }
          return LoadingScreen();
        },
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context, CalendarDTO data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: _buildTodayTag(DateTime.now())),
        _buildTableCalendar(context, data.schedulePlans),
        const SizedBox(height: 15,),
        Expanded(
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(45)),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: data.currentPlans.isNotEmpty
                ? _buildTimeline(context, data.currentPlans)
                : Text('Chưa đăng ký khóa học nào!'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTodayTag(DateTime date) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0), 
        color: Colors.pink.shade400
      ),
      child: Text(
        'Hôm nay, ngày ' + DateFormat('dd-MM-y').format(date),
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.white,
          fontWeight: FontWeight.bold
        )
      ),
    );
  }

  Widget _buildTableCalendar(BuildContext context, Map<dynamic, dynamic> plans) {
    return TableCalendar(
      focusedDay: _focusedDay!, 
      firstDay: DateTime.utc(2020, 1, 1), 
      lastDay: DateTime.utc(2030, 1, 1),   
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) => _setupCalendar(selectedDay, focusedDay),
      onFormatChanged: (format) => _setupCalendarFormat(format),
      onPageChanged: (focusedDay) => _setupCalendar(focusedDay, focusedDay),
      eventLoader: (day) {
        final DateTime schoolDay = DateTime(day.year, day.month, day.day);
        return plans.containsKey(schoolDay) ? plans[schoolDay] : [];
      },
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, day, events) {
          if (events.isNotEmpty) {
            return _buildEventsMarker(day, events);
          }
        }
      ),
    );
  }
  
  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      width: 12.0,
      height: 12.0,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.pink.shade400, // Change this color to change the event marker color
      ),
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 9.0,
          ),
        ),
      ),
    );
  }

  Widget _buildTimeline(BuildContext context, List<dynamic> data) {
    return FixedTimeline.tileBuilder(
      builder: TimelineTileBuilder.connectedFromStyle(
        nodePositionBuilder: (context, index) => 0,
        indicatorPositionBuilder: (context, index) => 1,
        connectorStyleBuilder: (context, index) => ConnectorStyle.solidLine,
        indicatorStyleBuilder: (context, index) => IndicatorStyle.outlined,
        itemExtent: 200.0,
        itemCount: data.length,
        contentsBuilder: (context, index) => SizedBox(
          child: Container(
            padding: const EdgeInsets.only(left: 15, bottom: 15, right: 5), 
            child: ItemSchedule(user: widget.user, data: data[index]), 
          ),
        ),
      ),
    );
  }

  void _setupCalendarFormat(CalendarFormat format) {
    setState(() {
      _calendarFormat = format;
    });
  }
  
  void _setupCalendar(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  StudyBloc _reload(UserDTO user, DateTime date) {
    final String formattedDate = DateFormat('y-MM-dd').format(date);
    return _studyBloc..add(StudyLoadScheduleDataEvent(token: user.token, date: formattedDate));
  }
}
