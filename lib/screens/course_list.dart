import 'package:anylearn/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_blocs.dart';
import '../blocs/course/course_blocs.dart';
import '../dto/user_courses_dto.dart';
import '../dto/user_dto.dart';
import 'account/course_list_tab.dart';
import 'loading.dart';

class CourseListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountCalendarScreen();
}

class _AccountCalendarScreen extends State<CourseListScreen> with TickerProviderStateMixin {
  TabController _tabController;
  AuthBloc _authBloc;
  CourseBloc _courseBloc;
  UserCoursesDTO _data;
  UserDTO _user;

  @override
  void didChangeDependencies() {
    _tabController = new TabController(vsync: this, length: 2, initialIndex: 0);
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    _courseBloc = BlocProvider.of<CourseBloc>(
        context); //CourseBloc(itemRepository: RepositoryProvider.of<ItemRepository>(context));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is AuthFailState) {
          Navigator.of(context).popAndPushNamed("/login");
        }
        if (state is AuthSuccessState) {
          _user = state.user;
          _courseBloc..add(ListCourseEvent(token: _user.token));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed("/course/form");
                }),
          ],
          title: const Text("Khóa học của bạn"),
          bottom: TabBar(controller: _tabController, tabs: [
            Tab(child: Text("Đang mở")),
            Tab(child: Text("Đã xong")),
          ]),
        ),
        body: BlocListener<CourseBloc, CourseState>(
          bloc: _courseBloc,
          listener: (context, state) {
            if (state is CourseFailState) {
              Scaffold.of(context).showSnackBar(new SnackBar(
                content: Text(state.error.toString()),
              ));
            }
            if (state is CourseSaveSuccessState) {
              _courseBloc..add(ListCourseEvent(token: _user.token));
            }
            if (state is CourseUserStatusSuccessState) {
              _courseBloc..add(ListCourseEvent(token: _user.token));
            }
          },
          child: BlocBuilder<CourseBloc, CourseState>(
              bloc: _courseBloc,
              builder: (context, state) {
                if (state is CourseListSuccessState) {
                  _data = state.data;
                }
                return _data == null
                    ? TabBarView(
                        controller: _tabController,
                        children: [LoadingWidget(), Text("")],
                      )
                    : TabBarView(controller: _tabController, children: [
                        CourseList(
                          list: _data.open,
                          hasMenu: true,
                          courseBloc: _courseBloc,
                          user: _user,
                        ),
                        CourseList(
                          list: _data.close,
                          hasMenu: false,
                        ),
                      ]);
              }),
        ),
      ),
    );
  }
}
