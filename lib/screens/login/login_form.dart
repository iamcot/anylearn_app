import 'package:anylearn/dto/login_callback.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:validators/validators.dart' as validator;

import '../../blocs/login/login_blocs.dart';
import '../../customs/register_curved_paint.dart';

class LoginForm extends StatelessWidget {
  final LoginCallback callback;
  final LoginBloc loginBloc;
  final _formKey = GlobalKey<FormState>();
  final FocusNode _phoneNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginForm({Key key, this.loginBloc, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    return BlocListener<LoginBloc, LoginState>(
      bloc: loginBloc,
      listener: (context, state) {
        if (state is LoginFailState) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              '${state.error}',
              maxLines: 2,
            ),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        bloc: loginBloc,
        builder: (context, state) {
          return Container(
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  CustomPaint(
                    child: Container(
                      height: 100.0,
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.only(right: width / 4, bottom: 20.0),
                      child: Text(
                        "Đăng nhập",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    painter: CustomCurvedPaint(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
                    child: TextFormField(
                      controller: _phoneController,
                      validator: (String value) {
                        if (!validator.isNumeric(value)) {
                          return "Số điện thoại không hợp lệ";
                        }
                        _formKey.currentState.save();
                        return null;
                      },
                      focusNode: _phoneNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _phoneNode, _passwordNode);
                      },
                      decoration: InputDecoration(
                        labelText: "Số điện thoại",
                        labelStyle: TextStyle(fontSize: 14.0),
                        prefixIcon: Icon(MdiIcons.phone),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Vui lòng nhập mật khẩu";
                        }
                        _formKey.currentState.save();
                        return null;
                      },
                      focusNode: _passwordNode,
                      textInputAction: TextInputAction.send,
                      onFieldSubmitted: (value) {
                        _submitForm(context);
                      },
                      decoration: InputDecoration(
                        labelText: "Mật khẩu",
                        prefixIcon: Icon(MdiIcons.lock),
                        labelStyle: TextStyle(fontSize: 14.0),
                      ),
                      obscureText: true,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent, Colors.blue]),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 48.0,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
                    child: FlatButton(
                      onPressed: state is! LoginInProgressState
                          ? () {
                              // FocusScope.of(context).requestFocus(new FocusNode());
                              _submitForm(context);
                            }
                          : () {},
                      child: state is! LoginInProgressState
                          ? Text(
                              "Đăng nhập",
                              style: TextStyle(fontSize: 16.0, color: Colors.white),
                            )
                          : CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 30.0),
                    child: Text.rich(
                      TextSpan(text: "Bạn chưa có tài khoản?", children: [
                        TextSpan(
                            text: " Đăng ký ngay",
                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).popAndPushNamed("/register", arguments: callback);
                              })
                      ]),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressedEvent(
        phone: _phoneController.text,
        password: _passwordController.text,
      ));
    }
  }
}
