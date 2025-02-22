import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/course/course_bloc.dart';
import '../customs/feedback.dart';
import '../dto/user_courses_dto.dart';
import '../main.dart';
import '../widgets/loading_widget.dart';
import 'account/course_list_tab.dart';

class CourseListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountCalendarScreen();
}

class _AccountCalendarScreen extends State<CourseListScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late CourseBloc _courseBloc;
  UserCoursesDTO? _data;

  @override
  void didChangeDependencies() {
    _tabController = new TabController(vsync: this, length: 2, initialIndex: 0);
    _courseBloc = BlocProvider.of<CourseBloc>(context);
    if (user.token == "") {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).popAndPushNamed("/login");
      });
    } else {
      _courseBloc..add(ListCourseEvent(token: user.token));
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed("/course/form");
              }),
        ],
        title: const Text("Khóa học của bạn").tr(),
        bottom: TabBar(controller: _tabController, tabs: [
          Tab(child: Text("Đang mở").tr()),
          Tab(child: Text("Đã xong").tr()),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: BlocListener<CourseBloc, CourseState>(
          bloc: _courseBloc,
          listener: (context, state) {
            if (state is CourseFailState) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text(state.error.toString()),
                ));
            }
            if (state is CourseSaveSuccessState) {
              _courseBloc..add(ListCourseEvent(token: user.token));
            }
            if (state is CourseUserStatusSuccessState) {
              // Navigator.of(context).pop();
              _courseBloc..add(ListCourseEvent(token: user.token));
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
                    : CustomFeedback(
                        user: user,
                        child: TabBarView(controller: _tabController, children: [
                          CourseList(
                            list: _data!.open,
                            hasMenu: true,
                            courseBloc: _courseBloc,
                            user: user,
                          ),
                          CourseList(
                            list: _data!.close,
                            hasMenu: false,
                            courseBloc: _courseBloc,
                            user: user,
                          ),
                        ]));
              }),
        ),
      ),
    );
  }
}
