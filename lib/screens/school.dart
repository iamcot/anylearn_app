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
import '../widgets/loading_widget.dart';
import 'school/school_body.dart';

class SchoolScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SchoolScreen();
}

class _SchoolScreen extends State<SchoolScreen> {
  late UsersBloc usersBloc;
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
        Text('title').tr();

    return Scaffold(
      appBar: BaseAppBar(
        user: user,
        title: "Học viện & Trung tâm đào tạo",
        screen: "school",
      ),
      body: BlocProvider<UsersBloc>(
          create: (context) => usersBloc,
          child: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
            if (state is UsersSchoolSuccessState) {
              return RefreshIndicator(
                child: CustomFeedback(user: user, child: SchoolBody(schoolsData: state.data)),
                onRefresh: _reloadPage,
              );
            }
            return LoadingWidget();
          })),
      floatingActionButton: FloatingActionButtonHome(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      bottomNavigationBar: BottomNav(
        route: BottomNav.SCHOOL_INDEX,
      ),
    );
  }

  Future<void> _reloadPage() async {
    usersBloc.add(UsersSchoolLoadEvent());
  }
}
