import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../blocs/account/account_blocs.dart';
import '../blocs/auth/auth_blocs.dart';
import '../widgets/loading_widget.dart';

class AccountPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountPasswordScreen();
}

class _AccountPasswordScreen extends State<AccountPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late String oldPassword;
  late String newPassword;
  late String confirmPassword;
  late AccountBloc _accountBloc;
  late AuthBloc _authBloc;
  bool loading = false;

  @override
  void didChangeDependencies() {
    _accountBloc = BlocProvider.of<AccountBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    final token = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Đổi mật khẩu".tr()),
      ),
      body: BlocListener(
        bloc: _accountBloc,
        listener: (context, state) {
          setState(() {
            loading = false;
          });
          if (state is AccChangePassSuccessState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                duration: Duration(seconds: 4),
                content:
                    Text("Mật khẩu đã được thay đổi. Vui lòng đăng nhập lại.".tr()),
              )).closed.then((value) {
                Navigator.of(context).pop();
                _authBloc.add(AuthLoggedOutEvent(token: token));
              });
          }
          if (state is AccChangePassFailState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                duration: Duration(seconds: 4),
                content: Text(state.error),
              ));
          }
        },
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                ),
                child: Text(
                  "Đổi mật khẩu của bạn".tr(),
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 30.0),
                child: TextFormField(
                  onSaved: (value) {
                    setState(() {
                      oldPassword = value!.trim();
                    });
                  },
                  validator: (value) {
                    if (value == "") {
                      return "Mật khẩu cũ là bắt buộc".tr();
                    }
                    _formKey.currentState!.save();
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Mật khẩu cũ".tr(),
                    icon: Icon(MdiIcons.keyRemove),
                  ),
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 30.0),
                child: TextFormField(
                  onSaved: (value) {
                    setState(() {
                      newPassword = value!.trim();
                    });
                  },
                  validator: (value) {
                    if (value!.length < 8) {
                      return "Mật khẩu ít nhất 8 kí tự".tr();
                    }
                    _formKey.currentState!.save();
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Mật khẩu mới".tr(),
                    icon: Icon(MdiIcons.formTextboxPassword),
                  ),
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 30.0),
                child: TextFormField(
                  onSaved: (value) {
                    setState(() {
                      confirmPassword = value!.trim();
                    });
                  },
                  validator: (value) {
                    if (value != newPassword) {
                      return "Xác nhận mât khẩu không đúng".tr();
                    }
                    _formKey.currentState!.save();
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Nhập lại mật khẩu mới".tr(),
                    icon: Icon(MdiIcons.formTextboxPassword),
                  ),
                  obscureText: true,
                ),
              ),
              Container(
                height: 36.0,
                margin:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                child: loading
                    ? LoadingWidget()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate() && !loading) {
                            _formKey.currentState!.save();
                            _accountBloc
                              ..add(AccChangePassEvent(
                                token: token,
                                newPass: newPassword,
                                oldPass: oldPassword,
                              ));
                            setState(() {
                              loading = true;
                            });
                          }
                        },
                        child: Text(
                          "Đổi mật khẩu".tr(),
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
