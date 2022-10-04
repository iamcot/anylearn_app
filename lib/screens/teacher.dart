import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/users/users_blocs.dart';
import '../customs/feedback.dart';
import '../main.dart';
import '../models/page_repo.dart';
import '../widgets/appbar.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/fab_home.dart';
import 'loading.dart';
import 'teacher/teacher_body.dart';

class TeacherScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeacherScreen();
}

class _TeacherScreen extends State<TeacherScreen> {
  late UsersBloc usersBloc;
  @override
  void didChangeDependencies() {
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    usersBloc = UsersBloc(pageRepository: pageRepo);
    usersBloc.add(UsersTeacherLoadEvent());
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: BaseAppBar(
          user: user,
          title: "Giảng viên & Chuyên gia".tr(),
          screen: "teacher",
        ),
        body: BlocProvider<UsersBloc>(
          create: (context) => usersBloc,
          child: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
            if (state is UsersTeacherSuccessState) {
              return RefreshIndicator(
                child: CustomFeedback(user: user, child: TeacherBody(teachers: state.data)),
                onRefresh: _reloadPage,
              );
            }
            return LoadingScreen();
          }),
        ),
        floatingActionButton: FloatingActionButtonHome(),
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        bottomNavigationBar: BottomNav(
          route: BottomNav.TEACHER_INDEX,
        ));
  }

  Future<void> _reloadPage() async {
    usersBloc.add(UsersTeacherLoadEvent());
  }
}
