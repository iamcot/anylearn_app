import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:overlay_support/overlay_support.dart';

import '../blocs/auth/auth_blocs.dart';
import '../dto/contract.dart';
import '../widgets/loading_widget.dart';

class ContractSignScreen extends StatefulWidget {
  final user;
  final contractId;

  const ContractSignScreen({key, this.user, this.contractId}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ContractSignScreen();
}

class _ContractSignScreen extends State<ContractSignScreen> {
  late AuthBloc _authBloc;
  ContractDTO? _contract;

  @override
  void initState() {
     _authBloc = BlocProvider.of<AuthBloc>(context)
      ..add(AuthContractLoadForSignEvent(
        token: widget.user.token,
        contractId: widget.contractId,
      ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("XEM/KÝ hợp đồng").tr(),
        centerTitle: false,
      ),
      body: BlocListener(
        bloc: BlocProvider.of<AuthBloc>(context),
        listener: (context, state) {
          if (state is AuthContractSignedSuccessState) {
            toast("Bạn đã ký thành công, anyLEARN sẽ kiểm tra và phản hồi trong thời gian sớm nhất.".tr());
            Navigator.of(context).pop(true);
          }
          if (state is AuthContractSignedFailState) {
            toast(state.error.toString());
          }
        },
        child: BlocBuilder(
            bloc: BlocProvider.of<AuthBloc>(context),
            builder: (context, state) {
              if (state is AuthContractLoadForSignSuccessState) {
                print(state.contract);
                _contract = state.contract;
              }
              return _contract == null
                  ? LoadingWidget()
                  : ListView(
                      children: [
                        _contract!.status == 1
                            ? Container(
                                padding: EdgeInsets.all(15),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                                      backgroundColor: MaterialStateProperty.all<Color>((Colors.green[600])!),
                                    ),
                                    onPressed: () {
                                      _authBloc
                                        ..add(AuthContractSignEvent(
                                            token: widget.user.token, contractId: widget.contractId));
                                    },
                                    child: Text("TÔI ĐÃ ĐỌC VÀ ĐỒNG Ý KÝ HỢP ĐỒNG").tr()),
                              )
                            : Container(),
                        Html(
                          data: _contract!.template,
                          shrinkWrap: true,
                        ),
                        _contract!.status == 1
                            ? Container(
                                padding: EdgeInsets.all(15),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                                      backgroundColor: MaterialStateProperty.all<Color>((Colors.green[600])!),
                                    ),
                                    onPressed: () {
                                      _authBloc
                                        ..add(AuthContractSignEvent(
                                            token: widget.user.token, contractId: widget.contractId));
                                    },
                                    child: Text("TÔI ĐÃ ĐỌC VÀ ĐỒNG Ý KÝ HỢP ĐỒNG").tr()),
                              )
                            : Container(),
                      ],
                    );
            }),
      ),
    );
  }
}
