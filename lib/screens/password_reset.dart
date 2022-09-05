import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:overlay_support/overlay_support.dart';

import '../blocs/auth/auth_blocs.dart';
import '../widgets/loading_widget.dart';

class PasswordResetScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PasswordResetScreen();
}

class _PasswordResetScreen extends State<PasswordResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  late AuthBloc _authBloc;
  bool sentOTP = false;

  @override
  void didChangeDependencies() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Khôi phục mật khẩu"),
      ),
      body: BlocListener(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is AuthPassOtpSuccessState) {
            setState(() {
              sentOTP = true;
            });
          }
          if (state is AuthPassOtpFailState) {
            toast(state.error);
          }
          if (state is AuthPassResetSuccessState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text("Thay đổi mật khẩu thành công. Vui lòng đăng nhập lại"),
              ));
            Navigator.of(context).pop();
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
                  sentOTP ? "Nhập OTP từ SMS và mật khẩu mới" : "Nhập SDT để nhận OTP",
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 30.0),
                child: TextFormField(
                  controller: _phoneController,
                  validator: (value) {
                    if (value == "") {
                      return "Bạn quên nhập số điện thoại rồi nè.";
                    }
                    _formKey.currentState!.save();
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Số điện thoại",
                    icon: Icon(MdiIcons.phone),
                  ),
                ),
              ),
              !sentOTP
                  ? Container()
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 30.0),
                          child: TextFormField(
                            controller: _otpController,
                            validator: (value) {
                              if (value! == "") {
                                return "Bạn kiểm tra tin nhắn để lấy mã OTP nhé.";
                              }
                              _formKey.currentState!.save();
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Mã OTP",
                              icon: Icon(MdiIcons.codeTags),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 30.0),
                          child: TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value!.length < 8) {
                                return "Mật khẩu ít nhất 8 kí tự";
                              }
                              _formKey.currentState!.save();
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Mật khẩu mới",
                              icon: Icon(MdiIcons.formTextboxPassword),
                            ),
                            obscureText: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 30.0),
                          child: TextFormField(
                            controller: _passwordConfirmController,
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return "Xác nhận mât khẩu không đúng";
                              }
                              _formKey.currentState!.save();
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Nhập lại mật khẩu mới",
                              icon: Icon(MdiIcons.formTextboxPassword),
                            ),
                            obscureText: true,
                          ),
                        ),
                      ],
                    ),
              Container(
                height: 36.0,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                child: BlocBuilder<AuthBloc, AuthState>(
                    bloc: _authBloc,
                    builder: (context, state) {
                      if (state is AuthPassOtpLoadingState || state is AuthPassResetLoadingState) {
                        return LoadingWidget();
                      }
                      return ElevatedButton(
                          onPressed: () {
                            if (!sentOTP) {
                              _authBloc..add(AuthPassOtpEvent(phone: _phoneController.text));
                            } else {
                              _authBloc
                                ..add(AuthPassResetEvent(
                                  phone: _phoneController.text,
                                  otp: _otpController.text,
                                  password: _passwordController.text,
                                  confirmPassword: _passwordConfirmController.text,
                                ));
                            }
                          },
                          child: Text("Gửi"));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
