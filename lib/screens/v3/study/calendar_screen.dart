import 'package:anylearn/app_datetime.dart';
import 'package:anylearn/blocs/study/study_bloc.dart';
import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/dto/v3/calendar_dto.dart';
import 'package:anylearn/models/page_repo.dart';
import 'package:anylearn/screens/loading.dart';
import 'package:anylearn/screens/v3/study/course_screen.dart';
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
  late CalendarDTO _data;

  @override
  void initState() {
    super.initState();
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    _studyBloc = StudyBloc(pageRepository: pageRepo);
    _loadBodyData();
  }

  @override
  void dispose() {
    _studyBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudyBloc, StudyState>(
      bloc: _loadBodyData(),
      builder: (context, state) {
        if (state is StudyLoadScheduleSuccessState) {
          _data = state.data;
          return Scaffold(
            backgroundColor: Colors.blue.shade50,
            // bottomNavigationBar: BottomNav(BottomNav.MYCLASS_INDEX),
            body: Container(
              margin: const EdgeInsets.only(top: kToolbarHeight),
              child: _buildBodyContent(context))
          );
        }
        return LoadingScreen();
      },
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: _buildTodayTag(DateTime.now()),
        ),
         const SizedBox(height: 5.0),
        _buildTableCalendar(context, _data.schedulePlans),
        const SizedBox(height: 15.0),
        Expanded(
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(45)),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: _data.currentPlans.isNotEmpty
                ? _buildTimeline(context, _data.currentPlans)
                : Text(
                 'Uh oh! 🌟 Bạn chưa tham gia bất kỳ khóa học nào sao?🌻🌻🌻 \nNhanh tay lên! Vũ trụ kiến thức đang chờ bạn khám phá!🚀✨',
                 style: TextStyle(fontSize: 16),
                ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTodayTag(DateTime date) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0), 
        gradient: LinearGradient(
            begin: Alignment.centerLeft, 
            end: Alignment.centerRight, 
            colors: [
              Colors.blue.shade100, 
              Colors.pink.shade100,
              Colors.blue.shade100, 
            ],
          ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: SizedBox(
              width: 10.0,
              child: Icon(Icons.arrow_back, color: Colors.white, size: 20.0,)
            ),
          ),
          Text(
            'Hôm nay, ngày ' + DateFormat(AppDateTime.REVERSE_DATE_FORMAT).format(date),
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
            )
          ),
          const SizedBox(width: 20.0, child: Text('🌸')),
        ],
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
        color: Colors.pink.shade300,
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
            child: InkWell(
              onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
                  return CourseScreen(orderItemID: data[index].orderItemID, user: widget.user);
                })
              ),
              child: ItemSchedule(data: data[index])
            ), 
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

  StudyBloc _loadBodyData() {
    DateTime dateFrom = _selectedDay!;
    DateTime dateTo = _selectedDay!;

    if (_calendarFormat == CalendarFormat.week) {;
      dateFrom = 7 != dateFrom.weekday 
        ? dateFrom.subtract(Duration(days: dateFrom.weekday)) 
        : dateFrom;
      dateTo = dateFrom.add(Duration(days: 6));
    } else if (_calendarFormat == CalendarFormat.twoWeeks) {
      dateFrom = dateFrom.subtract(Duration(days: dateFrom.weekday + 7));
      dateTo = dateTo.add(Duration(days: 13));
    } else if (_calendarFormat == CalendarFormat.month) {
      dateFrom = DateTime(dateFrom.year, dateFrom.month, 1);
      dateTo = DateTime(dateTo.year, dateTo.month + 1, 0);
    }
    
    return _studyBloc
      ..add(StudyLoadScheduleDataEvent(
        token: widget.user.token, 
        lookupDate: AppDateTime.convertDateFormat(_selectedDay!.toString()), 
        dateFrom: AppDateTime.convertDateFormat(dateFrom.toString()),
        dateTo: AppDateTime.convertDateFormat(dateTo.toString()),
      ));
  }
}
