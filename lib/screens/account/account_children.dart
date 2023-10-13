import 'package:anylearn/main.dart';
import 'package:anylearn/screens/webview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../blocs/account/account_bloc.dart';
import '../../dto/user_dto.dart';
import '../../models/user_repo.dart';

class AccountChildrenScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountChildrenScreen();
}

class _AccountChildrenScreen extends State<AccountChildrenScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  // final _dobController = TextEditingController();
  final _dobController = new MaskedTextController(mask: '0000-00-00');
  DateFormat f = DateFormat("yyyy-MM-dd");
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
        title: Text("Quản lý tài khoản phụ").tr(),
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                _formEdit(context, 0, "", "");
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
                    _formEdit(context, state.children[index].id,
                        state.children[index].name, state.children[index].dob);
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

  void _formEdit(BuildContext context, int id, String name, String dob) {
    //child:
    Text(context.locale.toString());

    _titleController.text = name;
    _dobController.text = dob;
    showDialog(
              

        context: context,
        builder: (context) => SimpleDialog(
              contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 0),
              children: [
                        Text('title'),

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
                              labelText: "Tên thành viên".tr(),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                            onTap: () {
                              DatePicker.showDatePicker(
                                context,
                                onConfirm: (time) {
                                  _dobController.text = f.format(time);
                                },
                                maxTime: DateTime.now(),
                                currentTime: _dobController.text == ""
                                    ? DateTime.now()
                                    : DateTime.parse(_dobController.text),
                              );
                            },
                            controller: _dobController,
                            decoration: InputDecoration(
                              labelText: "Ngày tháng năm sinh (YYYY-mm-dd)".tr(),
                            ),
                          ),
                        )
                      ],
                    )),
                BlocListener(
                    bloc: _accountBloc,
                    listener: (context, state) {
                      if (state is AccSaveChildrenSuccessState) {
                        toast("Lưu thành công!".tr());
                        _accountBloc
                          ..add(AccLoadChildrenEvent(token: user.token));
                        Navigator.of(context).pop();
                        if (user.inRegisterClassId > 0) {
                          _add2Cart(context, user.token, user.inRegisterClassId,
                              state.id);
                        }
                      } else if (state is AccChildrenFailState) {
                        toast(state.error);
                        _accountBloc..add(AccLoadChildrenEvent(token: user.token));
                      }
                    },
                    child: ElevatedButton(
                      onPressed: () {
                        _accountBloc
                          ..add(AccSaveChildrenEvent(
                              id: id,
                              name: _titleController.text,
                              dob: _dobController.text,
                              token: user.token));
                      },
                      child: BlocBuilder(
                        bloc: _accountBloc,
                        builder: (context, state) {
                          if (state is AccSaveChildrenLoadingState) {
                            return Container(
                              padding: EdgeInsets.all(2),
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                            );
                          }
                          return id == 0
                              ? Text("Thêm tài khoản mới").tr()
                              : Text("Cập nhật tài khoản").tr();
                        },
                      ),
                    )),
              ],
            ));
  }

  void _add2Cart(BuildContext context, String token, int itemId, int childId) {
    String url = config.webUrl + "add2cart?class=$itemId&child=$childId";
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => WebviewScreen(
              url: url,
              token: token,
            )));
  }
}
