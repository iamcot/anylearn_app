import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:image_picker/image_picker.dart';

import '../blocs/auth/auth_blocs.dart';
import '../dto/contract.dart';
import '../dto/user_dto.dart';
import '../widgets/gradient_button.dart';
import '../widgets/loading_widget.dart';
import 'draw.dart';

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
          if (state is AuthContractSignedSuccessState) {
            _authBloc..add(AuthCheckEvent());
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text("Bạn đã ký hợp đồng thành công."),
              ));
          }
          if (state is AuthContractSignedFailState) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder(
            bloc: BlocProvider.of<AuthBloc>(context),
            builder: (context, state) {
              if (state is AuthSuccessState) {
                _user = state.user;
                _authBloc..add(AuthContractLoadEvent(token: _user.token));
              }
              if (state is AuthContractLoadSuccessState) {
                _contract = state.contract;
              }

              if (state is AuthContractSignedSuccessState) {
                // _contract.signed = state.image;
                _authBloc..add(AuthCheckEvent());
              }
              return _contract == null
                  ? LoadingWidget()
                  : Container(
                      padding: EdgeInsets.all(15),
                      child: ListView(
                        children: [
                          Column(children: [
                            Container(
                              height: 200,
                              padding: EdgeInsets.all(10),
                              child: BlocBuilder(
                                  bloc: _authBloc,
                                  builder: (context, state) {
                                    if (state is AuthContractSigningState) {
                                      return LoadingWidget();
                                    }
                                    return _contract.signed == null
                                        ? Center(child: Text("Bạn chưa ký."))
                                        : CachedNetworkImage(
                                            imageUrl: _contract.signed,
                                            fit: BoxFit.fitHeight,
                                          );
                                  }),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GradientButton(
                                  function: () async {
                                    final File image = await ImagePicker.pickImage(
                                      source: ImageSource.camera,
                                    );
                                    if (image != null) {
                                      _authBloc..add(AuthContractSignEvent(token: _user.token, file: image));
                                    }
                                  },
                                  title: "CHỤP ẢNH & KÝ",
                                ),
                                SizedBox(width: 15),
                                GradientButton(
                                  function: () async {
                                    final File image = await Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (context) => new DrawScreen()));
                                    if (image != null) {
                                      _authBloc..add(AuthContractSignEvent(token: _user.token, file: image));
                                    }
                                  },
                                  color: Colors.green,
                                  colorSub: Colors.greenAccent,
                                  title: "VẼ & KÝ",
                                )
                              ],
                            )
                          ]),
                          Divider(),
                          _contract.template == null ? LoadingWidget() : Html(data: _contract.template),
                        ],
                      ),
                    );
            }),
      ),
    );
  }
}
