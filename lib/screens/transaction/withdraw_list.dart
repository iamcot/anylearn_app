import 'package:anylearn/widgets/bank_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../dto/transaction_dto.dart';

class WithdrawList extends StatelessWidget {
  final list;

  const WithdrawList({key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final DateFormat _dateFormat = DateFormat("hh:mm\ndd/MM/yy");
    final NumberFormat _monneyFormat = NumberFormat("###,###,###", "vi_VN");
    return ListBody(
      children: list
          .map((TransactionDTO e) => ListTile(
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
                      ? TextSpan(text: "Đã xác nhận".tr(), style: TextStyle(color: Colors.green))
                      : (TextSpan(text: "Chưa xác nhận".tr(), style: TextStyle(color: Colors.grey), children: [
                          TextSpan(
                              text: "\nThông tin ngân hàng",
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return SimpleDialog(
                                          title: Text("Tiền sẽ được chuyển khoản về ngân hàng sau:",
                                              style: TextStyle(fontSize: 12.0)).tr(),
                                          children: [
                                            ListTile(
                                              title: Text("Ngân hàng").tr(),
                                              subtitle: Text(e.bankInfo.bankName),
                                            ),
                                            ListTile(
                                              title: Text("Chi nhánh").tr(),
                                              subtitle: Text(e.bankInfo.bankBranch),
                                            ),
                                            ListTile(
                                              title: Text("Số tài khoản").tr(),
                                              subtitle: Text(e.bankInfo.bankNo),
                                            ),
                                            ListTile(
                                              title: Text("Người  thụ hưởng").tr(),
                                              subtitle: Text(e.bankInfo.accountName),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  "OK",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                }),
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
