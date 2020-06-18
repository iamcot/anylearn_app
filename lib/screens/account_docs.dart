import 'dart:io';

import 'package:anylearn/blocs/account/account_blocs.dart';
import 'package:anylearn/dto/user_doc_dto.dart';
import 'package:anylearn/models/user_repo.dart';
import 'package:anylearn/screens/account/user_doc_list.dart';
import 'package:anylearn/screens/loading.dart';
import 'package:anylearn/widgets/gradient_button.dart';
import 'package:anylearn/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AccountDocsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountDocsScreen();
}

class _AccountDocsScreen extends State<AccountDocsScreen> {
  AccountBloc accountBloc;
  List<UserDocDTO> userDocs;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userRepo = RepositoryProvider.of<UserRepository>(context);
    accountBloc = AccountBloc(userRepository: userRepo);
  }

  @override
  Widget build(BuildContext context) {
    final token = ModalRoute.of(context).settings.arguments;
    accountBloc..add(AccLoadDocsEvent(token: token));
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý chứng chỉ"),
        centerTitle: false,
      ),
      body: BlocProvider<AccountBloc>(
        create: (context) => accountBloc,
        child: BlocListener<AccountBloc, AccountState>(
          bloc: accountBloc,
          listener: (context, state) {
            if (state is AccountFailState) {
              Scaffold.of(context).showSnackBar(new SnackBar(
                content: Text(state.error.toString()),
              ));
            }
          },
          child: BlocBuilder<AccountBloc, AccountState>(
            bloc: accountBloc,
            builder: (context, state) {
              if (state is AccLoadDocsSuccessState) {
                userDocs = state.userDocs;
              }
              if (state is AccAddDocSuccessState) {
                userDocs = state.userDocs;
              }
              if (state is AccRemoveDocSuccessState) {
                userDocs = state.userDocs;
              }
              return userDocs == null
                  ? LoadingScreen()
                  : Container(
                      child: ListView(
                        children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: Colors.blue,
                                  onPressed: () async {
                                    final File image = await ImagePicker.pickImage(
                                      source: ImageSource.camera,
                                    );
                                    if (image != null) {
                                      accountBloc..add(AccAddDocEvent(token: token, file: image));
                                    }
                                  },
                                  child: (state is AccAddDocLoadingState)
                                      ? LoadingWidget(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          "Thêm chứng chỉ mới",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                ),
                              ),
                              Divider(thickness: 10),
                            ] +
                            (userDocs == null
                                ? []
                                : userDocs
                                    .map((e) => e == null
                                        ? null
                                        : Container(
                                            height: 100,
                                            padding: EdgeInsets.only(bottom: 5),
                                            child: ListTile(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    child: SimpleDialog(
                                                      children: <Widget>[
                                                        Image.network(
                                                          e.data,
                                                          fit: BoxFit.fitWidth,
                                                        ),
                                                        FlatButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: Text("Đóng"))
                                                      ],
                                                    ));
                                              },
                                              title: Image.network(
                                                e.data,
                                                fit: BoxFit.cover,
                                              ),
                                              trailing: IconButton(
                                                  icon: Icon(Icons.delete),
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      child: AlertDialog(
                                                          content: Text("Bạn có muốn xóa file này"),
                                                          actions: [
                                                            FlatButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                              child: Text("Bỏ qua"),
                                                            ),
                                                            RaisedButton(
                                                                onPressed: () {
                                                                  accountBloc
                                                                    ..add(
                                                                        AccRemoveDocEvent(token: token, fileId: e.id));
                                                                  Navigator.of(context).pop();
                                                                },
                                                                color: Colors.red,
                                                                child: Text("Xóa"))
                                                          ]),
                                                    );
                                                  }),
                                            ),
                                          ))
                                    .toList()),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
