import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/transaction/transaction_blocs.dart';
import '../customs/feedback.dart';
import '../dto/const.dart';
import '../dto/transaction_dto.dart';
import '../main.dart';
import '../models/transaction_repo.dart';
import 'account/transaction_list.dart';
import 'loading.dart';

class TransactionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransactionScreen();
}

class _TransactionScreen extends State<TransactionScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final monneyF = new NumberFormat("###,###,###", "vi_VN");
  late TransactionBloc _transBloc;
  Map<String, List<TransactionDTO>>? data;

  @override
  void didChangeDependencies() {
    if (user.token == "") {
      Navigator.of(context).popAndPushNamed("/login");
    }
    final transRepo = RepositoryProvider.of<TransactionRepository>(context);
    _transBloc = TransactionBloc(transactionRepository: transRepo);
    _transBloc..add(LoadTransactionHistoryEvent(token: user.token));
    int initTab = 0;
    try {
      initTab =
          int.parse((ModalRoute.of(context)?.settings.arguments.toString())!);
    } catch (e) {}

    _tabController =
        new TabController(vsync: this, length: 2, initialIndex: initTab);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionBloc>(
        create: (BuildContext context) => _transBloc,
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionHistorySuccessState) {
              data = state.history;
            }
            return data == null
                ? LoadingScreen()
                : Scaffold(
                    appBar: AppBar(
                      centerTitle: false,
                      title: const Text("Giao dịch của tôi"),
                      actions: <Widget>[
                        IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () {
                              _transBloc
                                ..add(LoadTransactionHistoryEvent(
                                    token: user.token));
                            })
                      ],
                      bottom: PreferredSize(
                        child: user.disableAnypoint
                            ? Container()
                            : Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Card(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Row(children: [
                                                Expanded(
                                                  child: Text(
                                                    "anyPoint",
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                // Text.rich(
                                                //   TextSpan(
                                                //       text: "RÚT ĐIỂM",
                                                //       style: TextStyle(
                                                //         fontSize: 12.0,
                                                //         color: Colors.orange,
                                                //         fontWeight: FontWeight.bold,
                                                //       ),
                                                //       recognizer: TapGestureRecognizer()
                                                //         ..onTap = () async {
                                                //           await Navigator.of(context).pushNamed("/withdraw");
                                                //           _authBloc = BlocProvider.of<AuthBloc>(context)
                                                //             ..add(AuthCheckEvent());
                                                //         }),
                                                // ),
                                              ]),
                                              padding: EdgeInsets.all(10.0),
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 0.1))),
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(
                                                    top: 10.0, bottom: 10.0),
                                                child: Text(
                                                  monneyF.format(user.walletC),
                                                  style: TextStyle(
                                                      color: Colors.orange,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30.0),
                                                )),
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                  TabBar(controller: _tabController, tabs: [
                                    Tab(child: Text("Lịch sử thanh toán")),
                                    Tab(child: Text("Lịch sử anyPoint")),
                                    // Tab(
                                    //   child: Text("Chờ thanh toán"),
                                    // )
                                  ]),
                                ],
                              ),
                        preferredSize: user.disableAnypoint
                            ? Size.fromHeight(0)
                            : Size.fromHeight(150.0),
                      ),
                    ),
                    body: CustomFeedback(
                      user: user,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          TransactionList(
                            transactions: data![MyConst.WALLET_M]!,
                            tab: "wallet_m",
                          ),
                          user.disableAnypoint
                              ? Container()
                              : TransactionList(
                                  transactions: data![MyConst.WALLET_C]!,
                                  tab: "wallet_c"),
                        ],
                      ),
                    ),
                  );
          },
        ));
  }
}
