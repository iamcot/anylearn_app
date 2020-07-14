import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';
import '../blocs/transaction/transaction_blocs.dart';
import '../customs/feedback.dart';
import '../dto/const.dart';
import '../dto/transaction_dto.dart';
import '../dto/user_dto.dart';
import '../models/transaction_repo.dart';
import 'account/transaction_list.dart';
import 'loading.dart';

class TransactionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransactionScreen();
}

class _TransactionScreen extends State<TransactionScreen> with TickerProviderStateMixin {
  TabController _tabController;
  AuthBloc _authBloc;
  UserDTO _user;
  final monneyF = new NumberFormat("###,###,###", "vi_VN");
  TransactionBloc _transBloc;
  Map<String, List<TransactionDTO>> data;

  @override
  void didChangeDependencies() {
    final transRepo = RepositoryProvider.of<TransactionRepository>(context);
    _transBloc = TransactionBloc(transactionRepository: transRepo);
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    _tabController =
        new TabController(vsync: this, length: 2, initialIndex: ModalRoute.of(context).settings.arguments ?? 0);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is AuthFailState) {
            Navigator.of(context).popAndPushNamed("/login");
          }
          if (state is AuthSuccessState) {
            _user = state.user;
            _transBloc.add(LoadTransactionHistoryEvent(token: _user.token));
          }
        },
        child: BlocProvider<TransactionBloc>(
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
                        bottom: PreferredSize(
                          child: Column(
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
                                                "Tài khoản tiền",
                                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                  text: "NẠP TIỀN",
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  recognizer: TapGestureRecognizer()
                                                    ..onTap = () {
                                                      Navigator.of(context).pushNamed("/deposit");
                                                    }),
                                            ),
                                          ]),
                                          padding: EdgeInsets.all(10.0),
                                          decoration:
                                              const BoxDecoration(border: Border(bottom: BorderSide(width: 0.1))),
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                            child: Text(
                                              monneyF.format(_user.walletM),
                                              style: TextStyle(
                                                  color: Colors.blue, fontWeight: FontWeight.w200, fontSize: 30.0),
                                            )),
                                      ],
                                    ),
                                  )),
                                  Expanded(
                                      child: Card(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Row(children: [
                                            Expanded(
                                              child: Text(
                                                "Tài khoản điểm",
                                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                  text: "ĐỔI ĐIỂM",
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.orange,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  recognizer: TapGestureRecognizer()
                                                    ..onTap = () {
                                                      Navigator.of(context).pushNamed("/withdraw");
                                                    }),
                                            ),
                                          ]),
                                          padding: EdgeInsets.all(10.0),
                                          decoration:
                                              const BoxDecoration(border: Border(bottom: BorderSide(width: 0.1))),
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                            child: Text(
                                              monneyF.format(_user.walletC),
                                              style: TextStyle(
                                                  color: Colors.orange, fontWeight: FontWeight.w200, fontSize: 30.0),
                                            )),
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                              TabBar(controller: _tabController, tabs: [
                                Tab(child: Text("Tài khoản tiền")),
                                Tab(child: Text("Tài khoản điểm")),
                              ]),
                            ],
                          ),
                          preferredSize: Size.fromHeight(150.0),
                        ),
                      ),
                      body: CustomFeedback(
                        user: _user,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            TransactionList(transactions: data[MyConst.WALLET_M]),
                            TransactionList(transactions: data[MyConst.WALLET_C]),
                          ],
                        ),
                      ),
                    );
            },
          ),
        ));
  }
}
