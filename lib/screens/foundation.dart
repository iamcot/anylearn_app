import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../blocs/transaction/transaction_blocs.dart';
import '../models/transaction_repo.dart';
import '../widgets/loading_widget.dart';

class FoundationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FoundationScreen();
}

class _FoundationScreen extends State<FoundationScreen> {
  final formatMoney = NumberFormat("###,###,###", "vi_VN");
  TransactionBloc _transBloc;
  @override
  void didChangeDependencies() {
    final transRepo = RepositoryProvider.of<TransactionRepository>(context);
    _transBloc = TransactionBloc(transactionRepository: transRepo);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("anyLEARN Foundation"),
      ),
      body: BlocProvider<TransactionBloc>(
        create: (BuildContext context) => _transBloc..add(LoadFoundationEvent()),
        child: BlocBuilder<TransactionBloc, TransactionState>(builder: (context, state) {
          if (state is FoundationSuccessState) {
            return Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    formatMoney.format(state.value),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.orangeAccent),
                  ),
                  SizedBox(height: 20,),
                  Icon(
                    MdiIcons.handHeart,
                    color: Colors.pink,
                    size: width / 4,
                  ),
                  Padding(
                    padding: EdgeInsets.all(width/8.0),
                    child: Text(
                      "Một phần lợi nhuận từ các giao dịch sẽ được trích vào quỹ anyFoundation.",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            );
          }
          return LoadingWidget();
        }),
      ),
    );
  }
}
