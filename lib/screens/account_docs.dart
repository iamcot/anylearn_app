import 'dart:io';

import 'package:anylearn/customs/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../blocs/account/account_blocs.dart';
import '../dto/user_doc_dto.dart';
import '../models/user_repo.dart';
import '../widgets/loading_widget.dart';
import 'loading.dart';

class AccountDocsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountDocsScreen();
}

class _AccountDocsScreen extends State<AccountDocsScreen> {
  late AccountBloc accountBloc;
  List<UserDocDTO>? userDocs;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userRepo = RepositoryProvider.of<UserRepository>(context);
    accountBloc = AccountBloc(userRepository: userRepo);
  }

  @override
  Widget build(BuildContext context) {
    final token = ModalRoute.of(context)!.settings.arguments.toString();
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
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
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
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final PickedFile? image =
                                        await _imagePicker.getImage(
                                      source: ImageSource.camera,
                                    );
                                    if (image != null) {
                                      accountBloc
                                        ..add(AccAddDocEvent(
                                            token: token,
                                            file: File(image.path)));
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
                            (userDocs!.length == 0
                                ? []
                                : userDocs!
                                    .map((e) => Container(
                                          height: 200,
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: ListTile(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      SimpleDialog(
                                                        children: <Widget>[
                                                          CustomCachedImage(
                                                              url: e.data),
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child:
                                                                  Text("Đóng"))
                                                        ],
                                                      ));
                                            },
                                            title:
                                                CustomCachedImage(url: e.data),
                                            trailing: IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                            content: Text(
                                                                "Bạn có muốn xóa file này"),
                                                            actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child:
                                                                Text("Bỏ qua"),
                                                          ),
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                accountBloc
                                                                  ..add(AccRemoveDocEvent(
                                                                      token:
                                                                          token,
                                                                      fileId: e
                                                                          .id));
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                primary:
                                                                    Colors.red,
                                                              ),
                                                              child:
                                                                  Text("Xóa"))
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
