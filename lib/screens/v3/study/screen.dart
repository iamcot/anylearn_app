import 'package:anylearn/blocs/study/study_bloc.dart';
import 'package:anylearn/models/page_repo.dart';
import 'package:anylearn/screens/v3/study/course_list.dart';
import 'package:anylearn/screens/v3/study/item_course.dart';
import 'package:anylearn/screens/v3/study/item_schedule.dart';
import 'package:anylearn/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
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
      body: BlocBuilder(
        bloc: _studyBloc..add(StudyLoadDataEvent(token: 'token', studentID: 12)),
        builder: (context, state) {
          switch (state.runtimeType) { 
            case StudyLoadSuccessState:
              final data = (state as StudyLoadSuccessState).data;
              print('objec');
              return Container(
                color: Colors.white,
                child: ListView(
                  children: [
                    CourseList(
                      title: 'Khóa học tham gia',
                      intro: 'Đây là các khóa học bạn đang hoặc chuẩn bị tham gia.',
                      data: data.upcomingCourses,
                      itemBuilder: (index) => ItemCourse(index),
                    ),
                    // CourseList(
                    //   title: 'Lịch học hôm nay',
                    //   intro: 'Đây là lịch học hôm nay của bạn.',
                    // itemBuilder: (index) => ItemSchedule(index),
                    // ),
                    // CourseList(
                    //   title: 'Khóa học hoàn thành',
                    //   intro: 'Đây là các khóa học bạn đã hoàn thành.',
                    //   itemBuilder: (index) => ItemCourse(state.data.doneCourses),
                    // ),                  
                  ]
                ),
              );
            default:
              return Placeholder();
          }
        } 
      ),
      bottomNavigationBar: BottomNav(BottomNav.MYCLASS_INDEX),
    );
  }
}