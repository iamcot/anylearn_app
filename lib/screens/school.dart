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
    return BlocProvider<UsersBloc>(create: (context) {
      return usersBloc;
    }, child: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
      if (state is UsersSchoolSuccessState) {
        return Scaffold(
          appBar: BaseAppBar(
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
  }
}
