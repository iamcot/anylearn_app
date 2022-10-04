import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../blocs/transaction/transaction_blocs.dart';
import '../dto/foundation_dto.dart';
import '../models/transaction_repo.dart';
import 'account/transaction_list.dart';
import 'ask/ask_list.dart';
import 'loading.dart';

class FoundationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FoundationScreen();
}

class _FoundationScreen extends State<FoundationScreen> with TickerProviderStateMixin {
  final formatMoney = NumberFormat("###,###,###", "vi_VN");
  late TransactionBloc _transBloc;
  late FoundationDTO data;
  TabController? _tabController;
  int initTab = 0;

  @override
  void didChangeDependencies() {
    final transRepo = RepositoryProvider.of<TransactionRepository>(context);
    _transBloc = TransactionBloc(transactionRepository: transRepo);
    try {
      initTab = int.parse((ModalRoute.of(context)?.settings.arguments.toString())!);
    } catch (e) {
      initTab = 0;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return RefreshIndicator(
      onRefresh: () async {
        _transBloc..add(LoadFoundationEvent());
      },
      child: BlocProvider<TransactionBloc>(
          create: (BuildContext context) => _transBloc..add(LoadFoundationEvent()),
          child: BlocBuilder<TransactionBloc, TransactionState>(builder: (context, state) {
            if (state is FoundationLoadingState) {
              return LoadingScreen();
            }
            if (state is FoundationSuccessState) {
              data = state.value;
              if (_tabController == null) {
                _tabController =
                    new TabController(vsync: this, length: data.enableIosTrans ? 2 : 1, initialIndex: initTab);
              }

              return Scaffold(
                appBar: AppBar(
                  title: Text("anyLEARN Foundation"),
                  centerTitle: false,
                  actions: [
                    IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          _transBloc..add(LoadFoundationEvent());
                        })
                  ],
                  bottom: PreferredSize(
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  MdiIcons.handHeart,
                                  color: Colors.pinkAccent,
                                  size: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    formatMoney.format(data.value),
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30.0),
                                  ),
                                ),
                              ],
                            )),
                        TabBar(
                            controller: _tabController,
                            tabs: data.enableIosTrans
                                ? [Tab(child: Text("Đóng góp".tr())), Tab(child: Text("Điểm tin".tr()))]
                                : [Tab(child: Text("Điểm tin".tr()))]),
                      ],
                    ),
                    preferredSize: Size.fromHeight(100.0),
                  ),
                ),
                body: TabBarView(
                  controller: _tabController,
                  children: data.enableIosTrans
                      ? [
                          TransactionList(
                            transactions: data.history,
                            tab: "wallet_c",
                          ),
                          CustomScrollView(slivers: <Widget>[AskList(data: data.news)]),
                        ]
                      : [
                          CustomScrollView(slivers: <Widget>[AskList(data: data.news)]),
                        ],
                ),
              );
            }
            return LoadingScreen();
          })),
    );
  }
}
