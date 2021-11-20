import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/items/items_blocs.dart';
import '../main.dart';
import '../models/page_repo.dart';
import '../widgets/appbar.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/fab_home.dart';
import 'items/items_body.dart';
import 'loading.dart';

class ItemsTeacherScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemsTeacherScreen();
}

class _ItemsTeacherScreen extends State<ItemsTeacherScreen> {
  ItemsBloc itemsBloc;

  @override
  void didChangeDependencies() {
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    itemsBloc = ItemsBloc(pageRepository: pageRepo);
    final userId = ModalRoute.of(context).settings.arguments;
    itemsBloc..add(ItemsTeacherLoadEvent(id: userId));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemsBloc>(
      create: (context) => itemsBloc,
      child: BlocListener<ItemsBloc, ItemsState>(
        listener: (context, state) {
          if (state is ItemsLoadFailState) {
            Navigator.of(context).popUntil(ModalRoute.withName("/"));
          }
        },
        child: BlocBuilder<ItemsBloc, ItemsState>(
          builder: (context, state) {
            if (state is ItemsTeacherSuccessState) {
              return Scaffold(
                appBar: BaseAppBar(
                  user: user,
                  title: state.data.user.name,
                ),
                body: ItemsBody(
                  itemsDTO: state.data,
                ),
                floatingActionButton: FloatingActionButtonHome(),
                floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
                bottomNavigationBar: BottomNav(
                  route: BottomNav.TEACHER_INDEX,
                  user: user,
                ),
              );
            }
            return LoadingScreen();
          },
        ),
      ),
    );
  }
}
