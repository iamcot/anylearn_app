import 'package:anylearn/blocs/account/account_bloc.dart';
import 'package:anylearn/blocs/auth/auth_bloc.dart';
import 'package:anylearn/blocs/study/study_bloc.dart';
import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/dto/v3/registered_item_dto.dart';
import 'package:anylearn/models/page_repo.dart';
import 'package:anylearn/screens/loading.dart';
import 'package:anylearn/screens/v3/study/calendar_screen.dart';
import 'package:anylearn/screens/v3/study/course_list.dart';
import 'package:anylearn/screens/v3/study/course_screen.dart';
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
  late AccountBloc _accountBloc;
  late UserDTO _user;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(AuthCheckEvent());
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    _studyBloc = StudyBloc(pageRepository: pageRepo);
    _accountBloc = BlocProvider.of<AccountBloc>(context);
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
        _user = state.user;
        return BlocListener<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is AccJoinSuccessState) {
              _loadBodyContent(_user);
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: BottomNav(BottomNav.MYCLASS_INDEX),
            body: DefaultTextStyle(
              child: _buildBodyContent(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 14,
              ),
            ),
          )
        );
      }
      if (state is AuthFailState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed('/login');
        });
      }
      return LoadingScreen();
    });
  }

  Widget _buildBodyContent() {
    return BlocBuilder(
        bloc: _loadBodyContent(_user),
        builder: (context, state) {
          switch (state.runtimeType) {
            case StudyLoadSuccessState:
              final data = (state as StudyLoadSuccessState).data;
              return Container(
                margin: const EdgeInsets.only(top: 30),
                child: ListView(children: [
                  Greeting(
                    numCourses: data.numCourses,
                    userInfo: data.userInfo,
                    userAccounts: data.userAccounts,
                    changeAccountCallback: (account) => _loadBodyContent(account)
                  ),
                  if (data.upcomingCourses.isNotEmpty)
                    CourseList(
                      title: 'Khóa học',
                      intro: 'Các khóa học bạn đang hoặc chuẩn bị tham gia.',
                      data: data.upcomingCourses,
                      itemBuilder: (course) => ItemCourse(
                        data: course, 
                        callbackConfirmation: (data) => _updateConfirmation(data),
                      ),
                      linkBuilder: (orderItemID) =>_buildCourseScreenRoute(context, orderItemID),
                    ),
                  if (data.ongoingCourses.isNotEmpty)
                    CourseList(
                      title: 'Lịch học',
                      intro: 'Thời khóa biểu tuần này của bạn. ',
                      data: data.ongoingCourses,
                      additional: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    CalendarScreen(user: _user))),
                        child: Text('(Tra lịch)',
                            style: TextStyle(color: Colors.blue.shade300)),
                      ),
                      itemBuilder: (schedule) => ItemSchedule(data: schedule),
                      linkBuilder: (orderItemID) => _buildCourseScreenRoute(context, orderItemID),
                      scrollDirection: Axis.vertical,
                    ),
                  if (data.completedCourses.isNotEmpty)
                    CourseList(
                      title: 'Hoàn thành',
                      intro: 'Các khóa học bạn đã hoàn thành.',
                      data: data.completedCourses,
                      itemBuilder: (course) => ItemCourse(
                        data: course, 
                        type: ItemCourse.COMPLETION_TYPE,
                        callbackConfirmation: (data) => _updateConfirmation(data),
                      ),
                      linkBuilder: (orderItemID) => _buildCourseScreenRoute(context, orderItemID),
                    ),
                  if (data.upcomingCourses.isEmpty &&
                      data.upcomingCourses.isEmpty &&
                      data.completedCourses.isEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Uh oh! 🌟 Bạn chưa tham gia bất kỳ khóa học nào trên AnyLearn sao?🌻🌻🌻 \nNhanh tay lên! Vũ trụ kiến thức đang chờ bạn khám phá!🚀✨',
                              maxLines: 10,
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ]),
              );
            default:
              return LoadingScreen();
          }
        });
  }

  Route _buildCourseScreenRoute(BuildContext context, int orderItemID) {
    return MaterialPageRoute(
        builder: (context) => CourseScreen(orderItemID: orderItemID, user: _user)
    );
  }

  StudyBloc _loadBodyContent(UserDTO account) {
    return _studyBloc..add(StudyLoadMainDataEvent(account: account, token: _user.token));
  }

   void _updateConfirmation(RegisteredItemDTO data) {
    _accountBloc..add(AccJoinCourseEvent(
        token: _user.token,
        itemId: data.id,
        scheduleId: data.orderItemID,
        childId: _user.id
    ));
  }

}
