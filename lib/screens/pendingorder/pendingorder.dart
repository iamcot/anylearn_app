import 'package:anylearn/blocs/pendingorder/pendingorder_blos.dart'
    show
        LoadPendingorderPageEvent,
        PendingOrderBloc,
        PendingOrderFailState,
        PendingOrderState;
import 'package:anylearn/customs/feedback.dart';
import 'package:anylearn/dto/const.dart';
import 'package:anylearn/dto/pending_order_dto.dart';
import 'package:anylearn/main.dart';
import 'package:anylearn/models/user_repo.dart';
import 'package:anylearn/screens/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

class PendingOrder extends StatefulWidget {
  const PendingOrder({Key? key}) : super(key: key);

  @override
  State<PendingOrder> createState() => _MyWidgetState();
}

@override
class _MyWidgetState extends State<PendingOrder> with TickerProviderStateMixin {
  late PendingOrderBloc _pendingorderBloc;
  late int id;
  late int userId;
  Map<String, List<PendingOrderDTO>>? data;
  final monneyF = new NumberFormat("###,###,###", "vi_VN");

  void didChangeDependencies() {
    if (user.token == "") {
      Navigator.of(context).popAndPushNamed("/login");
    }

    final pendingOrderRepo = RepositoryProvider.of<UserRepository>(context);
    _pendingorderBloc =
        PendingOrderBloc(pendingorderRepository: pendingOrderRepo);
    _pendingorderBloc..add(LoadPendingorderPageEvent(id: id, userId: userId));
    // int initTab = 0;
    // try {
    //   initTab =
    //       int.parse((ModalRoute.of(context)?.settings.arguments.toString())!);
    // } catch (e) {}

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
            // if (state is PendingOrderSuccessState) {
            //   data = state.load;
            // }

            return data == null
                ? LoadingScreen()
                : Scaffold(
                    appBar: AppBar(
                      centerTitle: false,
                      title: Text("Chờ thanh toán"),
                    ),
                    body: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                          child: DataTable(
                              columns: [
                            DataColumn(
                              label: Text("ID"),
                            ),
                            DataColumn(
                              label: Text("user_id"),
                            ),
                            DataColumn(
                              label: Text("quantity"),
                            ),
                            DataColumn(
                              label: Text("amount"),
                            ),
                            DataColumn(
                              label: Text("status"),
                            ),
                            DataColumn(
                              label: Text("delivery_name"),
                            ),
                            DataColumn(
                              label: Text("delivery_address"),
                            ),
                            DataColumn(
                              label: Text("delivery_phone"),
                            ),
                            DataColumn(
                              label: Text("payment"),
                            ),
                            DataColumn(
                              label: Text("created_at"),
                            ),
                            DataColumn(
                              label: Text("updated_at"),
                            ),
                            DataColumn(
                              label: Text("sale_id"),
                            ),
                            DataColumn(
                              label: Text("classes"),
                            ),
                          ],
                              rows: state.load.map((load) => DataRow(cells: [
                                    DataCell(Text(load.id)),
                                    DataCell(Text(load.userId)),
                                    DataCell(Text(load.quantity)),
                                    DataCell(Text(load.amount)),
                                    DataCell(Text(load.status)),
                                    DataCell(Text(load.deliveryName)),
                                    DataCell(Text(load.deliveryAddress)),
                                    DataCell(Text(load.deliveryPhone)),
                                    DataCell(Text(load.payment)),
                                    DataCell(Text(load.createdAt)),
                                    DataCell(Text(load.updatedAt)),
                                    DataCell(Text(load.saleId)),
                                    DataCell(Text(load.classes)),
                                  ])))),
                    ),
                  );
          })),
    );
  }
}
