import 'package:anylearn/dto/bank_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../dto/transaction_dto.dart';

class DepositList extends StatefulWidget {
  final List<TransactionDTO> list;
  final BankDTO configBank;

  const DepositList({Key key, this.list, this.configBank}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositList();
}

class _DepositList extends State<DepositList> {
  @override
  Widget build(BuildContext context) {
    final DateFormat _dateFormat = DateFormat("hh:mm\ndd/MM/yy");
    final NumberFormat _monneyFormat = NumberFormat("###,###,###", "vi_VN");
    return ListBody(
      children: widget.list
          .map((TransactionDTO e) => ListTile(
                onTap: e.status == 0
                    ? () {
                      BankDTO bankDTO = e.bankInfo ?? widget.configBank;
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                title:
                                    Text("Vui lòng chuyển khoản theo thông tin sau:", style: TextStyle(fontSize: 12.0)),
                                children: [
                                  ListTile(
                                    title: Text("Ngân hàng"),
                                    subtitle: Text(bankDTO.bankName),
                                  ),
                                  ListTile(
                                    title: Text("Chi nhánh"),
                                    subtitle: Text(bankDTO.bankBranch),
                                  ),
                                  ListTile(
                                    title: Text("Số tài khoản"),
                                    subtitle: Text(bankDTO.bankNo),
                                    trailing: Icon(Icons.content_copy),
                                    onTap: () {
                                      Clipboard.setData(new ClipboardData(text: e.bankInfo.bankNo));
                                      // Scaffold.of(context).showSnackBar(new SnackBar(
                                      //   content: Text("Đã chép STK"),
                                      //   duration: Duration(seconds: 2),
                                      // ));
                                    },
                                  ),
                                  ListTile(
                                    title: Text("Người  thụ hưởng"),
                                    subtitle: Text(bankDTO.accountName),
                                  ),
                                  ListTile(
                                    title: Text("Nội dung chuyển khoản"),
                                    subtitle: Text(bankDTO.content),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RaisedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      color: Colors.blue,
                                      child: Text(
                                        "OK",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      }
                    : null,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _dateFormat.format(DateTime.parse(e.createdDate)),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                ),
                contentPadding: EdgeInsets.all(8.0),
                title: Text(e.content),
                subtitle: Text.rich(
                  e.status > 0
                      ? TextSpan(text: "Đã xác nhận", style: TextStyle(color: Colors.green))
                      : (TextSpan(text: "Chưa xác nhận", style: TextStyle(color: Colors.grey), children: [
                          TextSpan(text: "\nCHUYỂN KHOẢN", style: TextStyle(color: Colors.blue)),
                        ])),
                ),
                trailing: Text(
                  _monneyFormat.format(e.amount),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: e.status > 0 ? Colors.green : Colors.grey,
                  ),
                ),
              ))
          .toList(),
    );
  }
}
