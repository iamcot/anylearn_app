import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/auth/auth_blocs.dart';
import '../blocs/transaction/transaction_blocs.dart';
import '../customs/feedback.dart';
import '../dto/const.dart';
import '../dto/transaction_config_dto.dart';
import '../dto/user_dto.dart';
import '../models/transaction_repo.dart';
import '../widgets/bank_info.dart';
import '../widgets/loading_widget.dart';
import 'transaction/deposit_list.dart';

class DepositScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DepositScreen();
}

class _DepositScreen extends State<DepositScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountInput = TextEditingController();
  final _moneyFormat = NumberFormat("###,###,###", "vi_VN");
  final _dateFormat = DateFormat("HH:mm dd/MM/yyyy");
  String _suggestText = "Nhập số tiền cần nhập hoặc chọn nhanh từ danh sách phía dưới";
  TransactionBloc _transBloc;
  AuthBloc _authBloc;
  TransactionConfigDTO config;
  var _paymentSelect = "atm";
  UserDTO user;

  @override
  void didChangeDependencies() {
    final transRepo = RepositoryProvider.of<TransactionRepository>(context);
    _transBloc = TransactionBloc(transactionRepository: transRepo);
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _amountInput.dispose();
    super.dispose();
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
          _transBloc.add(LoadTransactionPageEvent(type: MyConst.TRANS_TYPE_DEPOSIT, token: user.token));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Nạp tiền vào ví"),
          centerTitle: false,
        ),
        body: BlocProvider<TransactionBloc>(
          create: (BuildContext context) => _transBloc,
          child: BlocListener<TransactionBloc, TransactionState>(
            listener: (BuildContext context, TransactionState state) {
              if (state is TransactionDepositeSaveSuccessState) {
                _transBloc..add(LoadTransactionPageEvent(type: MyConst.TRANS_TYPE_DEPOSIT, token: user.token));
                Scaffold.of(context)
                    .showSnackBar(new SnackBar(
                      content: Text("Gửi lệnh nạp tiền thành công. Vui lòng kiểm tra bước tiếp theo."),
                      duration: Duration(seconds: 1),
                    ))
                    .closed
                    .then((value) => showDialog(
                        context: context,
                        builder: (context) {
                          return BankInfo(bankDTO: config.depositBank, phone: user.phone);
                        }));
              }
              if (state is TransactionSaveFailState) {
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: Text("Có lỗi khi lưu, vui lòng thử lại"),
                  duration: Duration(seconds: 2),
                ));
              }
            },
            child: BlocBuilder<TransactionBloc, TransactionState>(builder: (context, state) {
              if (state is TransactionConfigSuccessState) {
                config = state.configs;
              }
              return config == null
                  ? LoadingWidget()
                  : CustomFeedback(
                      user: user,
                      child: Form(
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
                                            text: "SỐ DƯ: ",
                                            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                                            children: [
                                              TextSpan(
                                                  text: _moneyFormat.format(user.walletM),
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16.0)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                            text: "GIAO DỊCH",
                                            style: TextStyle(color: Colors.blue),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.of(context).pushNamed("/transaction");
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
                                          onChanged: (value) {
                                            setState(() {
                                              _suggestText = _buildSuggestText(value, config);
                                            });
                                          },
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return "Bạn chưa nhập số tiền muốn nạp";
                                            }
                                            _formKey.currentState.save();
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Nhập số tiền cần nạp",
                                              hintStyle: TextStyle(
                                                fontSize: 20.0,
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
                                            _suggestText,
                                            style: TextStyle(fontSize: 12.0),
                                          ),
                                        ),
                                      ])),
                                ),
                                _buildSuggestInputs(context, config),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Phương thức thanh toán".toUpperCase(),
                                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                                  ),
                                ),
                                RadioListTile(
                                  dense: true,
                                  title: Text(
                                    "Chuyển khoản ngân hàng",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                      "Thông tin chuyển khoản sẽ được gửi tới quý khách hàng ngay khi xác nhận nạp tiền."),
                                  value: "atm",
                                  groupValue: _paymentSelect,
                                  onChanged: (value) {
                                    setState(() {
                                      _paymentSelect = "atm";
                                    });
                                  },
                                ),
                                Divider(),
                                RadioListTile(
                                  dense: true,
                                  title: Text.rich(TextSpan(
                                      text: "Đổi điểm.",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                      children: [
                                        TextSpan(
                                            text: " Bạn đang có: ",
                                            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal)),
                                        TextSpan(
                                            text: _moneyFormat.format(user.walletC),
                                            style: TextStyle(color: Colors.orange)),
                                        TextSpan(
                                            text: " điểm",
                                            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal)),
                                      ])),
                                  subtitle: Text("Bạn sẽ được chuyển sang trang đổi điểm."),
                                  value: "walletc",
                                  groupValue: _paymentSelect,
                                  onChanged: (value) {
                                    Navigator.of(context)
                                        .pushNamed("/exchange", arguments: TextEditingValue(text: "100"));
                                  },
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
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Text(
                                                      "Bạn đang gửi lệnh nạp ${_moneyFormat.format(int.parse(_amountInput.text))} vào ví tiền."),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Text("Nhập lại")),
                                                    RaisedButton(
                                                      color: Colors.blue,
                                                      onPressed: () {
                                                        _transBloc.add(SaveDepositEvent(
                                                            token: user.token,
                                                            amount: int.parse(_amountInput.text),
                                                            payment: _paymentSelect));
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text("Nạp tiền"),
                                                    )
                                                  ],
                                                );
                                              });
                                        }
                                      },
                                      child: Text(
                                        "NẠP TIỀN",
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
                                    "Lịch sử nạp tiền gần đây".toUpperCase(),
                                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                                  ),
                                ),
                                new DepositList(
                                  list: config.lastTransactions,
                                  configBank: config.depositBank,
                                  phone: user.phone,
                                ),
                                config.lastTransactions.length > 0
                                    ? Center(
                                        child: Text.rich(
                                          TextSpan(
                                              text: "TOÀN BỘ GIAO DỊCH",
                                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.of(context).pushNamed("/transaction");
                                                }),
                                        ),
                                      )
                                    : SizedBox(height: 0)
                              ],
                            )),
                      ),
                    );
              // );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestInputs(BuildContext context, TransactionConfigDTO config) {
    double width = MediaQuery.of(context).size.width / 6;
    double height = (config.suggests.length / config.suggestInputColumn).ceilToDouble() * width;
    return Container(
      padding: EdgeInsets.only(top: 15),
      height: height,
      child: GridView.count(
        childAspectRatio: 3.0,
        crossAxisCount: config.suggestInputColumn,
        // mainAxisSpacing: 10.0,
        // crossAxisSpacing: 10.0,
        children: config.suggests
            .map(
              (e) => InkWell(
                onTap: () {
                  _amountInput.text = e.toString();
                  setState(() {
                    _suggestText = _buildSuggestText(e.toString(), config);
                  });
                },
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      _moneyFormat.format(e),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: e == config.vipFee ? Colors.redAccent : Colors.blueAccent),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  String _buildSuggestText(String value, TransactionConfigDTO config) {
    String suggestText = "";
    final input = int.parse(value);
    DateTime vipStart = DateTime.now();
    if (user.expire > 0) {
      DateTime userVipExpire = new DateTime.fromMillisecondsSinceEpoch(user.expire * 1000);
      if (userVipExpire.isAfter(DateTime.now())) {
        vipStart = userVipExpire;
      }
    }
    suggestText = "Bạn sẽ nạp " + _moneyFormat.format(input);
    if (input == 0) {
      suggestText = "Nhập số tiền cần nhập hoặc chọn nhanh từ danh sách phía dưới";
    } else if (user.walletM < config.vipFee && input < config.vipFee - user.walletM) {
      suggestText += ". Hãy nạp thêm " +
          _moneyFormat.format(config.vipFee - input) +
          " để được tài khoản VIP đến ngày " +
          _dateFormat.format(vipStart.add(new Duration(days: config.vipDays)));
    } else {
      int totalVipDay = (input / (config.vipFee / config.vipDays)).ceil();
      suggestText +=
          " Thời hạn VIP của bạn sẽ đến ngày " + _dateFormat.format(vipStart.add(new Duration(days: totalVipDay)));
    }
    return suggestText;
  }
}
