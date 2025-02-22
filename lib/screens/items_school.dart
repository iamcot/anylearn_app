import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/items/items_bloc.dart';
import '../main.dart';
import '../models/page_repo.dart';
import '../widgets/appbar.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/fab_home.dart';
import 'items/items_body.dart';
import 'loading.dart';

class ItemsSchoolScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemsSchoolScreen();
}

class _ItemsSchoolScreen extends State<ItemsSchoolScreen> {
  late ItemsBloc itemsBloc;
  @override
  void didChangeDependencies() {
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    itemsBloc = ItemsBloc(pageRepository: pageRepo);
    final userId = ModalRoute.of(context)?.settings.arguments;
    itemsBloc..add(ItemsSchoolLoadEvent(id: int.parse(userId.toString())));
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
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
            if (state is ItemsSchoolSuccessState) {
              return Scaffold(
                appBar: BaseAppBar(
                  user: user,
                  title: state.data.user.name,
                  screen: "",
                ),
                body: ItemsBody(
                  itemsDTO: state.data,
                ),
                floatingActionButton: FloatingActionButtonHome(),
                floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
                bottomNavigationBar: BottomNav(
                  BottomNav.HOME_INDEX,
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
