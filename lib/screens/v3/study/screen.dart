import 'package:anylearn/blocs/study/study_bloc.dart';
import 'package:anylearn/models/page_repo.dart';
import 'package:anylearn/screens/loading.dart';
import 'package:anylearn/screens/v3/study/course_list.dart';
import 'package:anylearn/screens/v3/study/greeting.dart';
import 'package:anylearn/screens/v3/study/item_course.dart';
import 'package:anylearn/screens/v3/study/item_schedule.dart';
import 'package:anylearn/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({Key? key}) : super(key: key);

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
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
              return Container(
                margin: EdgeInsets.only(top: 15),
                color: Colors.white,
                child: ListView(
                  children: [
                    Greeting(
                      studentID: data.studentID,               
                      studentImage: data.studentImage,
                      studentList: data.studentList,
                      numCourses: data.numCourses,
                    ),
                    CourseList(
                      title: 'Khóa học',
                      intro: 'Đây là các khóa học bạn đang hoặc chuẩn bị tham gia.',
                      data: data.upcomingCourses,
                      itemBuilder: (course, type) => ItemCourse(data: course),
                    ),
                    CourseList(
                      title: 'Lịch học',
                      intro: 'Đây là thời khóa biểu tuần này của bạn.',
                      data: data.upcomingCourses,
                      itemBuilder: (course, type) => ItemSchedule(course),
                      itemWidth: MediaQuery.of(context).size.width - 90,
                      itemHeight: 155,
                    ),
                    CourseList(
                      title: 'Hoàn thành',
                      intro: 'Đây là các khóa học bạn đã hoàn thành.',
                      data: data.upcomingCourses,
                      itemType: ItemCourse.COMPLETION_TYPE,
                      itemBuilder: (course, type) => ItemCourse(data: course, type: type),
                    ),                  
                  ]
                ),
              );
            default:
              return LoadingScreen();
          }
        } 
      ),
      // bottomNavigationBar: BottomNav(BottomNav.MYCLASS_INDEX),
    );
  }
}