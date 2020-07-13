import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_blocs.dart';
import '../blocs/users/users_blocs.dart';
import '../customs/feedback.dart';
import '../dto/user_dto.dart';
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
  UserDTO user;
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
    return BlocBuilder<AuthBloc, AuthState>(
        bloc: BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent()),
        builder: (BuildContext context, AuthState state) {
          if (state is AuthSuccessState) {
            user = state.user;
          }
          return Scaffold(
              appBar: BaseAppBar(
                user: user,
                title: "Giảng viên & Chuyên gia",
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
              bottomNavigationBar: BottomNav(
                index: BottomNav.TEACHER_INDEX,
              ));
        });
  }

  Future<void> _reloadPage() async {
    usersBloc.add(UsersTeacherLoadEvent());
  }
}
