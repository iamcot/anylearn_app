import 'package:anylearn/screens/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/users/users_bloc.dart';
import '../blocs/users/users_event.dart';
import '../blocs/users/users_state.dart';
import '../dto/const.dart';
import '../dto/users_dto.dart';
import '../models/user_repo.dart';
import '../widgets/appbar.dart';
import '../widgets/bottom_nav.dart';
import 'teacher/teacher_body.dart';

class TeacherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userRepository = RepositoryProvider.of<UserRepository>(context);
    final UsersBloc _usersBloc = UsersBloc(role: MyConst.ROLE_TEACHER, userRepository: _userRepository)
      ..add(LoadList(type: MyConst.ROLE_TEACHER));
    UsersDTO _users;
    return Scaffold(
      appBar: BaseAppBar(
        title: "Giảng viên & Chuyên gia",
      ),
      body: BlocProvider<UsersBloc>(create: (context) {
        return _usersBloc;
      }, child: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
        if (state is UsersLoadSuccessState) {
          _users = state.users;
        }
        return _users != null ? TeacherBody(teachers: _users) : LoadingScreen();
      })),
      bottomNavigationBar: BottomNav(
        index: BottomNav.TEACHER_INDEX,
      ),
    );
  }
}
