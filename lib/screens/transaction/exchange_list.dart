import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../dto/transaction_dto.dart';

class ExchangeList extends StatelessWidget {
  final list;

  const ExchangeList({key, this.list}) : super(key: key);

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
                          TextSpan(text: "\nThông tin ngân hàng".tr(), style: TextStyle(color: Colors.blue)),
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
