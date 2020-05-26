import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';
import '../dto/account_transaction_dto.dart';
import '../dto/transaction_dto.dart';
import 'account/transaction_list.dart';

class TransactionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransactionScreen();
}

class _TransactionScreen extends State<TransactionScreen> with TickerProviderStateMixin {
  final Map<String, AccountTransactionDTO> data = {
    AccountTransactionDTO.WALLET_M: AccountTransactionDTO(
      currentAmount: 99123456,
      wallet: AccountTransactionDTO.WALLET_M,
      transactions: [
        TransactionDTO(
          id: 4,
          amount: -200000,
          content: "Mua khóa học thoát Ế",
          createdDate: "2020-05-20 09:00:00",
          status: 1,
          orderId: 2123012,
        ),
        TransactionDTO(
          id: 1,
          amount: 930000,
          content: "Nạp tiền vào ví tiền, thanh toán Momo",
          createdDate: "2020-05-10 09:00:00",
          status: 1,
        ),
      ],
    ),
    AccountTransactionDTO.WALLET_C: AccountTransactionDTO(
      currentAmount: 2300,
      wallet: AccountTransactionDTO.WALLET_C,
      transactions: [
        TransactionDTO(
          id: 6,
          amount: -100,
          content: "Chuyển điểm sang ví tiền",
          createdDate: "2020-05-13 19:30:00",
          status: 0,
        ),
        TransactionDTO(
          id: 3,
          amount: 50,
          content: "Chiết khấu từ đơn hàng của Thầy Giáo Ba, Thanh toán Khóa học X",
          createdDate: "2020-05-13 19:30:00",
          status: 1,
          orderId: 3423012,
        ),
        TransactionDTO(
          id: 2,
          amount: 100,
          content: "Chiết khấu trực tiếp mua hàng, Thanh toán Khóa học A",
          createdDate: "2020-05-12 12:30:00",
          status: 1,
          orderId: 73423012,
        ),
      ],
    )
  };

  bool createdTab = false;
  TabController _tabController;
  AuthBloc _authBloc;
  final monneyF = new NumberFormat("###,###,###", "vi_VN");

  @override
  void didChangeDependencies() {
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    _tabController = new TabController(vsync: this, length: 2, initialIndex: 0);
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
        },
        child: Scaffold(
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
                                    "Ví tiền",
                                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                      text: "NẠP TIỀN",
                                      style: TextStyle(fontSize: 12.0, color: Colors.blue),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.of(context).pushNamed("/deposit");
                                        }),
                                ),
                              ]),
                              padding: EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 0.1))),
                            ),
                            Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text(
                                  monneyF.format(data[AccountTransactionDTO.WALLET_M].currentAmount),
                                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w200, fontSize: 30.0),
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
                                    "Ví điểm",
                                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                      text: "ĐỔI ĐIỂM",
                                      style: TextStyle(fontSize: 12.0, color: Colors.orange),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.of(context).pushNamed("/withdraw");
                                        }),
                                ),
                              ]),
                              padding: EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 0.1))),
                            ),
                            Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text(
                                  monneyF.format(data[AccountTransactionDTO.WALLET_C].currentAmount),
                                  style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w200, fontSize: 30.0),
                                )),
                          ],
                        ),
                      )),
                    ],
                  ),
                  TabBar(controller: _tabController, tabs: [
                    Tab(child: Text("Ví tiền")),
                    Tab(child: Text("Ví điểm")),
                  ]),
                ],
              ),
              preferredSize: Size.fromHeight(150.0),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              TransactionList(transactions: data[AccountTransactionDTO.WALLET_M].transactions),
              TransactionList(transactions: data[AccountTransactionDTO.WALLET_C].transactions),
            ],
          ),
        ));
  }
}
