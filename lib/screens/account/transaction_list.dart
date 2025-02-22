import 'dart:math' as math;
import 'package:anylearn/dto/const.dart';
import 'package:anylearn/dto/transaction_dto.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionDTO> transactions;
  final String tab;

  const TransactionList({key, required this.transactions, required this.tab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dateF = new DateFormat("hh:mm dd/MM/yyyy");
    var monneyF = new NumberFormat("###,###,###", "vi_VN");
    return CustomScrollView(
      slivers: <Widget>[
        transactions.length > 0
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final itemIndex = index ~/ 2;
                    if (index.isEven) {
                      return ListTile(
                        title: Text(
                          transactions[itemIndex].content,
                          style: TextStyle(),
                        ),
                        subtitle: Text.rich(
                          TextSpan(
                              text: (transactions[itemIndex].orderId != null && transactions[itemIndex].orderId > 0
                                      ? "#" + transactions[itemIndex].orderId.toString() + " - "
                                      : "") +
                                  (transactions[itemIndex].createdDate == null
                                      ? ""
                                      : dateF.format(DateTime.parse(transactions[itemIndex].createdDate))),
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              children: [
                                TextSpan(text: "\n"),
                                _statusText(transactions[itemIndex].status),
                              ]),
                        ),
                        trailing: Text(
                          monneyF.format(usedAmount(transactions[itemIndex])),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: usedAmount(transactions[itemIndex]) > 0 ? Colors.green : Colors.red,
                          ),
                        ),
                      );
                    }
                    return Divider(
                      height: 0.0,
                    );
                  },
                  semanticIndexCallback: (Widget widget, int localIndex) {
                    if (localIndex.isEven) {
                      return localIndex ~/ 2;
                    }
                    return null;
                  },
                  childCount: math.max(0, transactions.length * 2 - 1),
                ),
              )
            : SliverToBoxAdapter(
                child: Text("Bạn không có giao dịch nào").tr(),
              )
      ],
    );
  }

  TextSpan _statusText(int status) {
    switch (status) {
      case MyConst.TRANS_STATUS_PENDING:
        return TextSpan(text: "Đang chờ".tr(), style: TextStyle(color: Colors.grey));
      case MyConst.TRANS_STATUS_APPROVE:
        return TextSpan(text: "Đã xác nhận".tr(), style: TextStyle(color: Colors.green));
      case MyConst.TRANS_STATUS_CANCEL:
        return TextSpan(text: "Bị từ chối".tr(), style: TextStyle(color: Colors.red));
    }
    return TextSpan(text: "");
  }

  int usedAmount(TransactionDTO trans) {
    if (trans.type == MyConst.TRANS_TYPE_EXCHANGE && tab == "wallet_c") {
      return trans.refAmount;
    }
    return trans.amount;
  }
}
