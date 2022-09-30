import 'package:anylearn/blocs/pendingorder/pendingorder_blos.dart';
import 'package:anylearn/customs/feedback.dart';
import 'package:anylearn/main.dart';
import 'package:anylearn/screens/loading.dart';
import 'package:anylearn/screens/pendingorders/pendingorder_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../dto/const.dart';
import '../../dto/pending_order_dto.dart';
import '../../models/pendingorder_repo.dart';

class PendingOrder extends StatefulWidget {
  const PendingOrder({Key? key}) : super(key: key);

  @override
  State<PendingOrder> createState() => _MyWidgetState();
}

@override
class _MyWidgetState extends State<PendingOrder> with TickerProviderStateMixin {
  late PendingOrderBloc _pendingorderBloc;
  Map<String, List<PendingOrderDTO>>? data;
  final monneyF = new NumberFormat("###,###,###", "vi_VN");

  void didChangeDependencies() {
    if (user.token == "") {
      Navigator.of(context).popAndPushNamed("/login");
    }
    // _pendingorderBloc = BlocProvider.of<PendingOrderBloc>(context)
    //   ..add(PendingOrderEvent());
    final pendingOrderRepo =
        RepositoryProvider.of<PendingorderRepository>(context);
    _pendingorderBloc =
        PendingOrderBloc(pendingorderRepository: pendingOrderRepo);
    // _pendingorderBloc..add(LoadPendingOrderHistoryEvent(token: user.token));
    int initTab = 0;
    try {
      initTab =
          int.parse((ModalRoute.of(context)?.settings.arguments.toString())!);
    } catch (e) {}

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
            if (state is PendingOrderFailState) {
              toast(state.error);
            }

            return data == null
                ? LoadingScreen()
                : Scaffold(
                    appBar: AppBar(
                      centerTitle: false,
                      title: Text("Chờ thanh toán"),
                    ),
                    body: CustomFeedback(
                        child: TabBarView(children: [
                          PendingOrderList(
                            pendingorders: data![MyConst.WALLET_M]!,
                            tab: "wallet_m",
                          )
                        ]),
                        user: user));
          })),
    );
  }
}
