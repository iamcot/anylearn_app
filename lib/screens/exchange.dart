import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/transaction/transaction_bloc.dart';
import '../dto/const.dart';
import '../dto/transaction_config_dto.dart';
import '../dto/user_dto.dart';
import '../models/transaction_repo.dart';
import '../widgets/loading_widget.dart';
import 'transaction/exchange_list.dart';

class ExchangeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExchangeScreen();
}

class _ExchangeScreen extends State<ExchangeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountInput = TextEditingController();
  final _ammountMInput = TextEditingController();
  final _moneyFormat = NumberFormat("###,###,###", "vi_VN");
  late TransactionBloc _transBloc;
  late UserDTO user;
  late TransactionConfigDTO config;
  late int max;

  @override
  void didChangeDependencies() {
    final transRepo = RepositoryProvider.of<TransactionRepository>(context);
    _transBloc = TransactionBloc(transactionRepository: transRepo);
    BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {    

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailState) {
          Navigator.of(context).popAndPushNamed("/login");
        }
        if (state is AuthSuccessState) {
          user = state.user;
          _transBloc.add(LoadTransactionPageEvent(type: MyConst.TRANS_TYPE_EXCHANGE, token: user.token));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Đổi điểm sang tài khoản tiền").tr(),
          centerTitle: false,
        ),
        body: BlocProvider<TransactionBloc>(
          create: (BuildContext context) => _transBloc,
          child: BlocListener<TransactionBloc, TransactionState>(
            listener: (BuildContext context, TransactionState state) {
              if (state is TransactionExchangeSaveSuccessState) {
                BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
                _amountInput.clear();
                _ammountMInput.clear();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text("Gửi lệnh đổi điểm thành công").tr(),
                    duration: Duration(seconds: 2),
                  )).closed.then((value) {
                    Navigator.of(context).pop();
                  });
              }
              if (state is TransactionSaveFailState) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text(state.error + "| Có lỗi khi lưu, vui lòng thử lại").tr(),
                    duration: Duration(seconds: 2),
                  ));
              }
            },
            child: BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is TransactionConfigSuccessState) {
                  config = state.configs;
                  max = user.walletC.floor();
                }
                return config == null
                    ? LoadingWidget()
                    : Form(
                        key: _formKey,
                        child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: ListView(
                              children: <Widget>[
                                Card(
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(children: [
                                      Expanded(
                                          child: Text.rich(
                                        TextSpan(
                                          text: "Số điểm: ".tr().toUpperCase(),
                                          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                                          children: [
                                            TextSpan(
                                                text: _moneyFormat.format(user.walletC),
                                                style: TextStyle(
                                                    color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 16.0)),
                                          ],
                                        ),
                                      )),
                                      Text.rich(
                                        TextSpan(
                                            text: "Lịch sử điểm".tr().toUpperCase(),
                                            style: TextStyle(color: Colors.blue),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.of(context).pushNamed("/transaction", arguments: 1);
                                              }),
                                      ),
                                    ]),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      TextFormField(
                                        controller: _amountInput,
                                        style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          setState(() {
                                            _ammountMInput.text = (int.parse(value) * config.rate).toString();
                                          });
                                        },
                                        validator: (value) {
                                          if (value == "") {
                                            return "Bạn chưa nhập số điểm muốn rút".tr();
                                          }
                                          if (int.parse(value.toString()) > max) {
                                            return "Bạn được rút tối đa $max điểm".tr();
                                          }
                                          _formKey.currentState?.save();
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Nhập số điểm muốn rút".tr(),
                                            hintStyle: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            icon: Text(
                                              "ĐIỂM".tr(),
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                      TextFormField(
                                        readOnly: true,
                                        controller: _ammountMInput,
                                        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: "Số tiền quy đổi rút được".tr(),
                                            hintStyle: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            icon: Text(
                                              "VND",
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 15.0),
                                  decoration: BoxDecoration(
                                    gradient:
                                        LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent, Colors.blue]),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  height: 40.0,
                                  child: TextButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState?.save();
                                          // showDialog(
                                          //   context: context,
                                          //   builder: (context) {
                                          //     return AlertDialog(
                                          //       content: Text("Chức năng đổi điểm tạm thời chưa hỗ trợ."),
                                          //     );
                                          //   },
                                          // );
                                          _transBloc.add(SaveExchangeEvent(
                                            amount: int.parse(_amountInput.text),
                                            token: user.token,
                                          ));
                                        }
                                      },
                                      child: Text(
                                        "Đổi điểm"..toUpperCase(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                                      ).tr()),
                                ),
                                Divider(
                                  thickness: 0,
                                  height: 20.0,
                                  color: Colors.transparent,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Lịch sử đổi điểm gần đây".toUpperCase(),
                                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                                  ).tr(),
                                ),
                                ExchangeList(list: config.lastTransactions),
                              ],
                            )),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
