import 'package:anylearn/blocs/users/users_state.dart';
import 'package:anylearn/screens/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/users/users_bloc.dart';
import '../blocs/users/users_event.dart';
import '../dto/const.dart';
import '../dto/users_dto.dart';
import '../models/user_repo.dart';
import '../widgets/appbar.dart';
import '../widgets/bottom_nav.dart';
import 'school/school_body.dart';

class SchoolScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userRepository = RepositoryProvider.of<UserRepository>(context);
    final UsersBloc _usersBloc = UsersBloc(role: MyConst.ROLE_SCHOOL, userRepository: _userRepository)
      ..add(LoadList(type: MyConst.ROLE_SCHOOL));
    UsersDTO _users;

    return Scaffold(
      appBar: BaseAppBar(
        title: "Học viện & Trung tâm đào tạo",
      ),
      body: BlocProvider<UsersBloc>(
        create: (context) {
          return _usersBloc;
        },
        child: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            if (state is UsersLoadSuccessState) {
              _users = state.users;
            }
            return _users != null ? SchoolBody(schoolsData: _users) : LoadingScreen();
          },
        ),
      ),
      bottomNavigationBar: BottomNav(
        index: BottomNav.SCHOOL_INDEX,
      ),
    );
  }
}
