import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';

import '../../dto/const.dart';
import '../../dto/pending_order_dto.dart';

class PendingOrderList extends StatelessWidget {
  final List<PendingOrderDTO> pendingorders;
  final String tab;

  const PendingOrderList({key, required this.pendingorders, required this.tab})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateFormat dateF = new DateFormat("hh:mm dd/MM/yyyy");
    var monneyF = new NumberFormat("###,###,###", "vi_VN");
    return CustomScrollView(
      slivers: <Widget>[
        pendingorders.length > 0
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final itemIndex = index ~/ 2;
                    if (index.isEven) {
                      return ListTile(
                        title: Text(
                          pendingorders[itemIndex].quantity.toString(),
                          style: TextStyle(),
                        ),
                        subtitle: Text.rich(
                          TextSpan(
                              text: (pendingorders[itemIndex].id != null &&
                                          pendingorders[itemIndex].id != 0
                                      ? "#" +
                                          pendingorders[itemIndex]
                                              .id
                                              .toString() +
                                          " - "
                                      : "") +
                                  (pendingorders[itemIndex].createdAt == null
                                      ? ""
                                      : dateF.format(DateTime.parse(
                                          pendingorders[itemIndex]
                                              .createdAt
                                              .toString()))),
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              children: [
                                TextSpan(text: "\n"),
                                _statusText(pendingorders[itemIndex].status),
                              ]),
                        ),
                        trailing: Text(
                          monneyF.format(usedAmount(pendingorders[itemIndex])),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: usedAmount(pendingorders[itemIndex]) > 0
                                ? Colors.green
                                : Colors.red,
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
                  childCount: math.max(0, pendingorders.length * 2 - 1),
                ),
              )
            : SliverToBoxAdapter(
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/");
                    },
                    child: Text(
                        "Bạn không có giao dịch nào. Xem các lịch học đang có")),
              )
      ],
    );
  }

  TextSpan _statusText(int status) {
    switch (status) {
      case MyConst.TRANS_STATUS_PENDING:
        return TextSpan(
            text: "Chờ duyet thanh toan ",
            style: TextStyle(color: Colors.grey));
    }
    return TextSpan(text: "");
  }

  int usedAmount(PendingOrderDTO pendingorders) {
    if (pendingorders.id == MyConst.TRANS_TYPE_EXCHANGE && tab == "wallet_c") {
      return pendingorders.userId ?? 0;
    }
    return pendingorders.amount ?? 0;
  }
}
