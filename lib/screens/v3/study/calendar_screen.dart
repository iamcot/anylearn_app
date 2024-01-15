import 'package:anylearn/blocs/study/study_bloc.dart';
import 'package:anylearn/models/page_repo.dart';
import 'package:anylearn/screens/loading.dart';
import 'package:anylearn/screens/v3/study/greeting.dart';
import 'package:anylearn/screens/v3/study/item_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timelines/timelines.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime? _selectedDay;
  DateTime? _focusedDay;
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
      backgroundColor: Colors.white,
      body: BlocBuilder<StudyBloc, StudyState>(
        bloc: _studyBloc..add(StudyLoadMainDataEvent(token: '', studentID: 12)),
        builder: (context, state) {
          if (state is StudyLoadSuccessState) {
            final data = state.data;
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ListView(
                children: [
                  Greeting(
                    numCourses: data.numCourses,
                    studentList: data.studentList,
                    studentInfo: _getCurrentStudentInfo (
                        data.studentID, data.studentList),
                    changeAccountCallback: (studentID) =>
                        _changeAccount(studentID, token: ''),
                  ),
                  Container(
                    color: Colors.amber.shade50,
                    child: TableCalendar(
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: DateTime.now(),
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay =
                              focusedDay; // update `_focusedDay` here as well
                        });
                      },
                      calendarFormat: CalendarFormat.week,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: FixedTimeline.tileBuilder(
                      builder: TimelineTileBuilder.connectedFromStyle(
                        nodePositionBuilder: (context, index) => 0.1,
                        indicatorPositionBuilder: (context, index) => 0,
                        connectorStyleBuilder: (context, index) =>
                            ConnectorStyle.solidLine,
                        indicatorStyleBuilder: (context, index) =>
                            IndicatorStyle.outlined,
                        itemExtent: 190.0,
                        itemCount: 3,
                        oppositeContentsBuilder: (context, index) =>
                            Text('12:00'),
                        contentsBuilder: (context, index) => SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ItemSchedule(data: data.scheduleCourses[index]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return LoadingScreen();
        },
      ),
    );
  }
    Future<void> _changeAccount(int studentID, {String token = ''}) async {
    _studyBloc..add(StudyLoadMainDataEvent(token: token, studentID: studentID));
  }

  Map<String, dynamic> _getCurrentStudentInfo(
      int studentID, List<dynamic> studentList) {
    return studentList.firstWhere((student) => student['id'] == studentID,
        orElse: () => {});
  }
}
