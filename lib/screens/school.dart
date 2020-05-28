import 'package:anylearn/blocs/auth/auth_blocs.dart';
import 'package:anylearn/dto/user_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/users/users_blocs.dart';
import '../models/page_repo.dart';
import '../widgets/appbar.dart';
import '../widgets/bottom_nav.dart';
import 'loading.dart';
import 'school/school_body.dart';

class SchoolScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SchoolScreen();
}

class _SchoolScreen extends State<SchoolScreen> {
  UsersBloc usersBloc;
  UserDTO user;
  @override
  void didChangeDependencies() {
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    usersBloc = UsersBloc(pageRepository: pageRepo);
    usersBloc.add(UsersSchoolLoadEvent());
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
          return BlocProvider<UsersBloc>(
              create: (context) => usersBloc,
              child: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
                if (state is UsersSchoolSuccessState) {
                  return Scaffold(
                    appBar: BaseAppBar(
                      user: user,
                      title: "Học viện & Trung tâm đào tạo",
                    ),
                    body: SchoolBody(schoolsData: state.data),
                    bottomNavigationBar: BottomNav(
                      index: BottomNav.SCHOOL_INDEX,
                    ),
                  );
                }
                return LoadingScreen();
              }));
        });
  }
}
