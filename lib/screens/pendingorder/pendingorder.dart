import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/pendingorder/pendingorder_blos.dart';
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
  // Map<String, List<PendingOrderDTO>>? datas;

  late TabController _tabController;

  final monneyF = new NumberFormat("###,###,###", "vi_VN");

  void didChangeDependencies() {
    if (user.token == "") {
      Navigator.of(context).popAndPushNamed("/login");
    }

    final pendingOrderRepo = RepositoryProvider.of<UserRepository>(context);
    _pendingorderBloc =
        PendingOrderBloc(pendingorderRepository: pendingOrderRepo);
    _pendingorderBloc..add(LoadPendingorderPageEvent(token: user.token));
    int initTab = 0;
    try {
      initTab =
          int.parse((ModalRoute.of(context)?.settings.arguments.toString())!);
    } catch (e) {}

    _tabController =
        new TabController(vsync: this, length: 2, initialIndex: initTab);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PendingOrderBloc>(
      create: (BuildContext context) => _pendingorderBloc,
      child: BlocBuilder<PendingOrderBloc, PendingOrderState>(
          bloc: _pendingorderBloc,
          builder: ((context, state) {
            // if (state is PendingOrderFailState) {
            //   toast(state.error);
            // }
            if (state is PendingOrderConfigSuccessState) {
              datas = state.configs;
            }

            return datas == null
                ? LoadingScreen()
                : Scaffold(
                    appBar: AppBar(
                      centerTitle: false,
                      title: Text("Chờ thanh toán"),
                    ),
                    body: ListView.separated(
                        itemBuilder: ((context, index) => ListTile(
                              isThreeLine: true,
                              leading: CircleAvatar(
                                  child: Text(datas![index].id.toString())),
                              title: Text(datas![index].createdAt.toString()),
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(datas![index].amount.toString()),
                                    Text(datas![index].classes.toString())
                                  ]),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => WebviewScreen(
                                          url: config.webUrl +
                                              "/payment-help?order_id=" +
                                              datas![index].id.toString(),
                                          token: user.token,
                                        )));
                              },
                            )),
                        separatorBuilder: ((context, index) => Divider()),
                        itemCount: datas!.length));

            // body: (SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: SingleChildScrollView(
            //     child: DataTable(
            //         columns: [
            //           DataColumn(
            //             label: Text("ID"),
            //           ),
            //           // DataColumn(
            //           //   label: Text("user_id"),
            //           // ),
            //           // DataColumn(
            //           //   label: Text("quantity"),
            //           // ),
            //           DataColumn(
            //             label: Text("amount"),
            //           ),
            //           // DataColumn(
            //           //   label: Text("status"),
            //           // ),
            //           // DataColumn(
            //           //   label: Text("payment"),
            //           // ),
            //           DataColumn(
            //             label: Text("created_at"),
            //           ),
            //           // DataColumn(
            //           //   label: Text("updated_at"),
            //           // ),
            //           // DataColumn(
            //           //   label: Text("sale_id"),
            //           // ),
            //           DataColumn(
            //             label: Text("classes"),
            //           ),
            //         ],
            //         rows: datas!
            //             .map<DataRow>((data) => DataRow(
            //                   cells: [
            //                     DataCell(Text(data.id.toString())),
            //                     // DataCell(Text(data.userId.toString())),
            //                     // DataCell(Text(data.quantity.toString())),
            //                     DataCell(Text(data.amount.toString())),
            //                     // DataCell(Text(data.status)),
            //                     // DataCell(Text(data.payment.toString())),
            //                     DataCell(
            //                         Text(data.createdAt.toString())),
            //                     // DataCell(Text(data.updatedAt.toString())),
            //                     // DataCell(Text(data.saleId.toString())),
            //                     DataCell(Text(data.classes.toString())),
            //                   ],
            //                 ))
            //             .toList()),
            //   ),
            // )),
          })),
    );
  }
}
