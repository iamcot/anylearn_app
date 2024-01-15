import 'package:anylearn/blocs/auth/auth_bloc.dart';
import 'package:anylearn/blocs/study/study_bloc.dart';
import 'package:anylearn/dto/user_dto.dart';
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
    BlocProvider.of<AuthBloc>(context).add(AuthCheckEvent());
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
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthSuccessState) {
        return _buildScaffold(context, _buildContent(state.user));
      }
      if (state is AuthFailState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed('/login');
        });
      }
      return LoadingScreen();
    });
  }

  Widget _buildScaffold(BuildContext context, Widget content) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNav(BottomNav.MYCLASS_INDEX),
      body: DefaultTextStyle(
        child: content,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.grey.shade800,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildContent(UserDTO user) {
    return BlocBuilder(
        bloc: _studyBloc
          ..add(StudyLoadMainDataEvent(token: 'token', studentID: user.id)),
        builder: (context, state) {
          switch (state.runtimeType) {
            case StudyLoadSuccessState:
              final data = (state as StudyLoadSuccessState).data;
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListView(children: [
                  Greeting(
                    numCourses: data.numCourses,
                    studentList: data.studentList,
                    studentInfo: _getCurrentStudentInfo(
                        data.studentID, data.studentList),
                    changeAccountCallback: (studentID) =>
                        _changeAccount(studentID, token: user.token),
                  ),
                  CourseList(
                    title: 'Khóa học',
                    intro: 'Các khóa học bạn đang hoặc chuẩn bị tham gia.',
                    data: data.upcomingCourses,
                    itemBuilder: (course, type) => ItemCourse(data: course),
                  ),
                  CourseList(
                    title: 'Lịch học',
                    intro: 'Thời khóa biểu tuần này của bạn.',
                    data: data.scheduleCourses,
                    itemBuilder: (schedule, type) =>
                        ItemSchedule(data: schedule),
                    scrollDirection: Axis.vertical,
                  ),
                  CourseList(
                    title: 'Hoàn thành',
                    intro: 'Các khóa học bạn đã hoàn thành.',
                    data: data.doneCourses,
                    itemType: ItemCourse.COMPLETION_TYPE,
                    itemBuilder: (course, type) =>
                        ItemCourse(data: course, type: type),
                  ),
                ]),
              );
            default:
              return LoadingScreen();
          }
        });
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
