import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../blocs/pendingorder/pendingorder_blocs.dart';
import '../../dto/pending_order_dto.dart';
import '../../main.dart';
import '../../models/user_repo.dart';
import '../loading.dart';
import '../webview.dart';

class PendingOrder extends StatefulWidget {
  const PendingOrder({Key? key}) : super(key: key);

  @override
  State<PendingOrder> createState() => _MyWidgetState();
}

@override
class _MyWidgetState extends State<PendingOrder> with TickerProviderStateMixin {
  late PendingOrderBloc _pendingorderBloc;

  List<PendingOrderDTO>? datas;

  final monneyF = new NumberFormat("###,###,###", "vi_VN");
  final dateF = new DateFormat("dd/MM\nyyyy");

  void didChangeDependencies() {
    if (user.token == "") {
      Navigator.of(context).popAndPushNamed("/login");
    }

    final pendingOrderRepo = RepositoryProvider.of<UserRepository>(context);
    _pendingorderBloc =
        PendingOrderBloc(pendingorderRepository: pendingOrderRepo);
    _pendingorderBloc..add(LoadPendingorderPageEvent(token: user.token));

    // _tabController =
    //     new TabController(vsync: this, length: 2, initialIndex: initTab);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PendingOrderBloc>(
      create: (BuildContext context) => _pendingorderBloc,
      child: BlocBuilder<PendingOrderBloc, PendingOrderState>(
          bloc: _pendingorderBloc,
          builder: ((context, state) {
            if (state is PendingOrderConfigSuccessState) {
              datas = state.configs;
            }

            return datas == null
                ? LoadingScreen()
                : Scaffold(
                    appBar: AppBar(
                      centerTitle: false,
                      title: Text("Chờ thanh toán").tr(),
                      actions: [
                        IconButton(
                            onPressed: () {
                              _pendingorderBloc
                                ..add(LoadPendingorderPageEvent(
                                    token: user.token));
                            },
                            icon: Icon(Icons.refresh))
                      ],
                    ),
                    body: ListView.separated(
                        itemBuilder: ((context, index) => ListTile(
                              isThreeLine: true,
                              leading: Text(
                                dateF.format(datas![index].createdAt!),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(Icons.chevron_right),
                              title: Text(datas![index].classes.toString()),
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tổng tiền: ".tr() +
                                          monneyF.format(datas![index].amount),
                                      style: TextStyle(color: Colors.pink),
                                    ),
                                  ]),
                              onTap: () async {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => WebviewScreen(
                                      url: config.webUrl +
                                          "/payment-help?order_id=" +
                                          datas![index].id.toString(),
                                      token: user.token,
                                    ),
                                  ),
                                );
                                toast(
                                    "Nếu bạn đã thực hiện chuyển khoản, vui lòng đợi ít phút để anyLEARN xác nhận đơn hàng."
                                        .tr());
                                _pendingorderBloc
                                  ..add(LoadPendingorderPageEvent(
                                      token: user.token));
                              },
                            )),
                        separatorBuilder: ((context, index) => Divider()),
                        itemCount: datas!.length));
          })),
    );
  }
}
