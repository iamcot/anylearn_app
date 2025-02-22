import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../dto/bank_dto.dart';
import '../../dto/const.dart';
import '../../dto/transaction_dto.dart';
import '../../widgets/bank_info.dart';

class DepositList extends StatefulWidget {
  final list;
  final configBank;
  final phone;

  const DepositList({key, this.list, this.configBank, this.phone}) : super(key: key);

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
                              return BankInfo(bankDTO: bankDTO, phone: widget.phone,);
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
                subtitle: Text.rich(_buildStatus(e.status)),
                trailing: Text(
                  _monneyFormat.format(e.amount),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: e.status == MyConst.TRANS_STATUS_APPROVE ? Colors.green : Colors.grey,
                  ),
                ),
              ))
          .toList(),
    );
  }

  TextSpan _buildStatus(int status) {

    if (status == MyConst.TRANS_STATUS_APPROVE) {
      return TextSpan(text: "Đã xác nhận".tr(), style: TextStyle(color: Colors.green));
    } else if (status == MyConst.TRANS_STATUS_CANCEL) {
      return TextSpan(text: "Đã từ chối".tr(), style: TextStyle(color: Colors.red));
    } else {
      return TextSpan(text: "Chưa xác nhận".tr(), style: TextStyle(color: Colors.grey), children: [
        TextSpan(text: "\nCHUYỂN KHOẢN".tr(), style: TextStyle(color: Colors.blue)),
      ]);
    }
  }
}
