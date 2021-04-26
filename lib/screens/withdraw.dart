import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/auth/auth_blocs.dart';
import '../blocs/transaction/transaction_blocs.dart';
import '../dto/bank_dto.dart';
import '../dto/const.dart';
import '../dto/transaction_config_dto.dart';
import '../dto/user_dto.dart';
import '../models/transaction_repo.dart';
import '../widgets/loading_widget.dart';
import 'transaction/bank_form.dart';
import 'transaction/withdraw_list.dart';

class WithdrawScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WithdrawScreen();
}

class _WithdrawScreen extends State<WithdrawScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountInput = TextEditingController();
  final _ammountMInput = TextEditingController();
  final _bankName = TextEditingController();
  final _bankBranch = TextEditingController();
  final _bankNo = TextEditingController();
  final _bankAccount = TextEditingController();
  final _moneyFormat = NumberFormat("###,###,###", "vi_VN");

  TransactionBloc _transBloc;
  UserDTO user;
  TransactionConfigDTO config;
  int keep;
  int max;

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
          _transBloc..add(LoadTransactionPageEvent(type: MyConst.TRANS_TYPE_WITHDRAW, token: user.token));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Rút tiền về ngân hàng"),
          centerTitle: false,
        ),
        body: BlocProvider<TransactionBloc>(
          create: (BuildContext context) => _transBloc,
          child: BlocListener<TransactionBloc, TransactionState>(
            listener: (BuildContext context, TransactionState state) {
              if (state is TransactionWithdrawSaveSuccessState) {
                BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: Text("Gửi lệnh rút tiền thành công. Vui lòng chờ chúng tôi xác nhận."),
                  duration: Duration(seconds: 2),
                ));
              }
              if (state is TransactionSaveFailState) {
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: Text("Có lỗi khi lưu, vui lòng thử lại"),
                  duration: Duration(seconds: 2),
                ));
              }
            },
            child: BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is TransactionConfigSuccessState) {
                  config = state.configs;
                  keep = (config.vipFee / config.rate).floor();
                  max = user.walletC.floor() - keep;
                  max = max > 0 ? max : 0;
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
                                          text: "SỐ ĐIỂM: ".toUpperCase(),
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
                                            text: "LỊCH SỬ ĐIỂM",
                                            style: TextStyle(color: Colors.blue),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.of(context).pushNamed("/transaction", arguments: 1);
                                              }),
                                      ),
                                    ]),
                                  ),
                                ),
                                Card(
                                  child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                                        TextFormField(
                                          controller: _amountInput,
                                          style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            setState(() {
                                              _ammountMInput.text = (int.parse(value) * config.rate).toString();
                                            });
                                          },
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return "Bạn chưa nhập số điểm muốn rút";
                                            }
                                            if (user.walletC < keep || int.parse(value) > max) {
                                              return "Bạn được rút tối đa $max điểm";
                                            }
                                            if (int.tryParse(value) < 0) {
                                              return "Số tiền không đúng";
                                            }
                                            _formKey.currentState.save();
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Nhập số điểm muốn rút",
                                              hintStyle: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              icon: Text(
                                                "ĐIỂM",
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              )),
                                        ),
                                        TextFormField(
                                          controller: _ammountMInput,
                                          readOnly: true,
                                          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              hintText: "Số tiền quy đổi dự kiến",
                                              hintStyle: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              icon: Text(
                                                "VND",
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Bạn được rút tối đa $max điểm",
                                            style: TextStyle(fontSize: 12.0),
                                          ),
                                        ),
                                      ])),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Thông tin ngân hàng".toUpperCase(),
                                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                                  child: BankForm(
                                    formKey: _formKey,
                                    bankName: _bankName,
                                    bankBranch: _bankBranch,
                                    bankNo: _bankNo,
                                    bankAccount: _bankAccount,
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
                                  child: FlatButton(
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                          // showDialog(
                                          //   context: context,
                                          //   builder: (context) {
                                          //     return AlertDialog(
                                          //       content: Text("Chức năng rút tiền tạm thời chưa hỗ trợ."),
                                          //     );
                                          //   },
                                          // );

                                          _transBloc.add(SaveWithdrawEvent(
                                              amount: _amountInput.text,
                                              token: user.token,
                                              bankInfo: BankDTO(
                                                  bankName: _bankName.text,
                                                  bankBranch: _bankBranch.text,
                                                  bankNo: _bankNo.text,
                                                  accountName: _bankAccount.text)));
                                        }
                                      },
                                      child: Text(
                                        "Rút tiền".toUpperCase(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                                      )),
                                ),
                                Divider(
                                  thickness: 0,
                                  height: 20.0,
                                  color: Colors.transparent,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Lịch sử rút tiền gần đây".toUpperCase(),
                                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                                  ),
                                ),
                                new WithdrawList(list: config.lastTransactions),
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
