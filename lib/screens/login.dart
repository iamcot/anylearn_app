import 'dart:io';

import 'package:anylearn/customs/register_curved_paint.dart';
import 'package:anylearn/dto/user_dto.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:validators/validators.dart' as validator;
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  UserDTO _user = new UserDTO();
  final FocusNode _phoneNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          "assets/images/logo_text.png",
          height: 40.0,
        ),
        elevation: 0.0,
      ),
      body: Container(
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
                  autofocus: true,
                  initialValue: _user.phone,
                  onSaved: (value) {
                    setState(() {
                      _user.phone = value;
                    });
                  },
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
                  onSaved: (value) {
                    setState(() {
                      _user.password = value;
                    });
                  },
                  validator: (String value) {
                    if (value.length < 8) {
                      return "Mật khẩu ít nhất 8 kí tự";
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  focusNode: _passwordNode,
                  textInputAction: TextInputAction.send,
                  onFieldSubmitted: (value) {
                    _passwordNode.unfocus();
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
                  onPressed: () {
                    _submitForm(context);
                  },
                  child: Text(
                    "Đăng nhập",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
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
                            Navigator.of(context).pushReplacementNamed("/register");
                          })
                  ]),
                ),
              )
            ],
          ),
        ),
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
      Navigator.of(context).pushReplacementNamed("/");
    }
  }
}
