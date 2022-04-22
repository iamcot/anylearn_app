import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../blocs/account/account_blocs.dart';
import '../../dto/user_dto.dart';
import '../../models/user_repo.dart';

class AccountChildrenScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountChildrenScreen();
}

class _AccountChildrenScreen extends State<AccountChildrenScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  late UserDTO user;
  late AccountBloc _accountBloc;

  @override
  void didChangeDependencies() {
    user = ModalRoute.of(context)!.settings.arguments as UserDTO;
    final userRepo = RepositoryProvider.of<UserRepository>(context);
    _accountBloc = AccountBloc(userRepository: userRepo);
    _accountBloc..add(AccLoadChildrenEvent(token: user.token));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý tài khoản phụ"),
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                _formEdit(context, 0, "");
              }),
        ],
      ),
      body: BlocBuilder(
          bloc: _accountBloc,
          builder: (context, state) {
            if (state is AccChildrenSuccessState) {
              return ListView.separated(
                itemBuilder: (context, index) => ListTile(
                  title: Text(state.children[index].name),
                  trailing: Icon(Icons.edit),
                  onTap: () {
                    _formEdit(context, state.children[index].id, state.children[index].name);
                  },
                ),
                separatorBuilder: (context, index) => Divider(),
                itemCount: state.children.length,
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  void _formEdit(BuildContext context, int id, String name) {
    _titleController.text = name;
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 0),
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              labelText: "Tên thành viên",
                            ),
                          ),
                        )
                      ],
                    )),
                BlocListener(
                    bloc: _accountBloc,
                    listener: (context, state) {
                      if (state is AccSaveChildrenSuccessState) {
                        toast("Lưu thành công!");
                        _accountBloc..add(AccLoadChildrenEvent(token: user.token));
                        Navigator.of(context).pop();
                      } else if (state is AccChildrenFailState) {
                        toast(state.error);
                      }
                    },
                    child: RaisedButton(
                      onPressed: () {
                        _accountBloc..add(AccSaveChildrenEvent(id: id, name: _titleController.text, token: user.token));
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: BlocBuilder(
                        bloc: _accountBloc,
                        builder: (context, state) {
                          if (state is AccSaveChildrenLoadingState) {
                            return Container(
                              padding: EdgeInsets.all(2),
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            );
                          }
                          return id == 0 ? Text("Thêm tài khoản mới") : Text("Cập nhật tài khoản");
                        },
                      ),
                    )),
              ],
            ));
  }
}
