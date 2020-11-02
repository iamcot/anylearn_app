import 'package:anylearn/screens/ask/ask_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../blocs/transaction/transaction_blocs.dart';
import '../dto/foundation_dto.dart';
import '../models/transaction_repo.dart';
import '../widgets/loading_widget.dart';
import 'account/transaction_list.dart';

class FoundationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FoundationScreen();
}

class _FoundationScreen extends State<FoundationScreen> with TickerProviderStateMixin {
  final formatMoney = NumberFormat("###,###,###", "vi_VN");
  TransactionBloc _transBloc;
  FoundationDTO data;
  TabController _tabController;

  @override
  void didChangeDependencies() {
    final transRepo = RepositoryProvider.of<TransactionRepository>(context);
    _transBloc = TransactionBloc(transactionRepository: transRepo);
    _tabController =
        new TabController(vsync: this, length: 2, initialIndex: ModalRoute.of(context).settings.arguments ?? 0);

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
              return Center(child: CircularProgressIndicator());
            }
            if (state is FoundationSuccessState) {
              data = state.value;

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
                                  color: Colors.pink[200],
                                  size: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    formatMoney.format(data.value),
                                    style:
                                        TextStyle(color: Colors.pink[200], fontWeight: FontWeight.bold, fontSize: 30.0),
                                  ),
                                ),
                              ],
                            )),
                        TabBar(controller: _tabController, tabs: [
                          Tab(child: Text("Đóng góp")),
                          Tab(child: Text("Điểm tin")),
                        ]),
                      ],
                    ),
                    preferredSize: Size.fromHeight(100.0),
                  ),
                ),
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    TransactionList(
                      transactions: data.history,
                      tab: "wallet_c",
                    ),
                    CustomScrollView(slivers: <Widget>[AskList(data: data.news)]),
                  ],
                ),
              );
            }
            return LoadingWidget();
          })),
    );
  }
}
