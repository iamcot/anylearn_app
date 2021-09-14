
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../blocs/auth/auth_blocs.dart';
import '../dto/contract.dart';
import '../dto/user_dto.dart';
import '../widgets/loading_widget.dart';

class ContractSignScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContractSignScreen();
}

class _ContractSignScreen extends State<ContractSignScreen> {
  UserDTO _user;
  AuthBloc _authBloc;
  ContractDTO _contract = ContractDTO();

  @override
  void didChangeDependencies() {
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý hợp đồng"),
        centerTitle: false,
      ),
      body: BlocListener(
        bloc: BlocProvider.of<AuthBloc>(context),
        listener: (context, state) {
          if (state is AuthSuccessState) {
            _user = state.user;
            _authBloc..add(AuthContractLoadEvent(token: _user.token));
          }
        },
        child: BlocBuilder(
            bloc: BlocProvider.of<AuthBloc>(context),
            builder: (context, state) {
              if (state is AuthContractLoadSuccessState) {
                _contract = state.contract;
              }
              return _contract == null
                  ? LoadingWidget()
                  : Container(
                      padding: EdgeInsets.all(15),
                      child: ListView(
                        children: [
                          _contract.template == null ? LoadingWidget() : Html(data: _contract.template),
                        ],
                      ),
                    );
            }),
      ),
    );
  }
}
