import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/users/users_blocs.dart';
import '../models/page_repo.dart';
import '../widgets/appbar.dart';
import '../widgets/bottom_nav.dart';
import 'loading.dart';
import 'teacher/teacher_body.dart';

class TeacherScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeacherScreen();
}

class _TeacherScreen extends State<TeacherScreen> {
  UsersBloc usersBloc;
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
    return BlocProvider<UsersBloc>(
      create: (context) {
        return usersBloc;
      },
      child: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
        if (state is UsersTeacherSuccessState) {
          return Scaffold(
              appBar: BaseAppBar(
                title: "Giảng viên & Chuyên gia",
              ),
              body: TeacherBody(teachers: state.data),
              bottomNavigationBar: BottomNav(
                index: BottomNav.TEACHER_INDEX,
              ));
        }
        return LoadingScreen();
      }),
    );
  }
}
