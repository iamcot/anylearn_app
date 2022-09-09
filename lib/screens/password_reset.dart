import 'package:anylearn/widgets/otpform.dart';
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
  // final _otpController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  late AuthBloc _authBloc;
  bool sentOTP = false;
  int steps = 1;
  bool checkotp = false;
  late String _otp;
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldfive = TextEditingController();
  final TextEditingController _fieldsix = TextEditingController();

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
        title: Text("Nhập mã OTP"),
      ),
      body: BlocListener(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is AuthPassOtpSuccessState) {
            setState(() {
              sentOTP = true;
              steps = 2;
            });
          }

          if (state is AuthPassOtpFailState) {
            toast(state.error);
          }
          if (state is AuthCheckPhoneOTPResetSuccessState) {
            setState(() {
              checkotp = true;
              steps = 3;
            });
          } else if (state is AuthCheckPhoneOtpFailState) {
            toast(state.error);
          }
          if (state is AuthPassResetSuccessState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(
                    "Thay đổi mật khẩu thành công. Vui lòng đăng nhập lại"),
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
                  sentOTP ? "Nhập OTP từ SMS " : "Nhập SDT để nhận OTP",
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]),
                ),
              ),
              SizedBox(height: 10),
              steps == 1
                  ? Padding(
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
                    )
                  : Container(),
              steps == 2
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        // Implement 6 input fields
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              otpform(_fieldOne, true),
                              otpform(_fieldTwo, false),
                              otpform(_fieldThree, false),
                              otpform(_fieldFour, false),
                              otpform(_fieldfive, false),
                              otpform(_fieldsix, false)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    )
                  : Container(),
              steps == 3
                  ? Column(
                      children: [
                        // SizedBox(height: 20),
                        // Padding(
                        //   padding:
                        //       const EdgeInsets.only(left: 15.0, right: 30.0),
                        //   child: TextFormField(
                        //     controller: _otp,
                        //     validator: (value) {
                        //       if (value! == "") {
                        //         return "Bạn kiểm tra tin nhắn để lấy mã OTP nhé.";
                        //       }
                        //       _formKey.currentState!.save();
                        //       return null;
                        //     },
                        //     decoration: InputDecoration(
                        //       labelText: "Mã OTP",
                        //       icon: Icon(MdiIcons.codeTags),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 10),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 30.0),
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
                        SizedBox(height: 10),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 30.0),
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
                    )
                  : Container(),
              SizedBox(height: 10),
              Container(
                height: 36.0,
                margin:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                child: BlocBuilder<AuthBloc, AuthState>(
                    bloc: _authBloc,
                    builder: (context, state) {
                      if (state is AuthPassOtpLoadingState) {
                        return LoadingWidget();
                      }
                      return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _otp = _fieldOne.text +
                                  _fieldTwo.text +
                                  _fieldThree.text +
                                  _fieldFour.text +
                                  _fieldfive.text +
                                  _fieldsix.text;
                            });

                            if (steps == 1) {
                              _authBloc
                                ..add(AuthPassOtpEvent(
                                    phone: _phoneController.text));
                            } else if (steps == 2) {
                              _authBloc
                                ..add(AuthCheckOtpEvent(
                                    otp: _otp, phone: _phoneController.text));
                            } else if (steps == 3) {
                              _authBloc
                                ..add(AuthPassResetEvent(
                                  phone: _phoneController.text,
                                  otp: _otp,
                                  // otp: _otpController.text,

                                  password: _passwordController.text,
                                  confirmPassword:
                                      _passwordConfirmController.text,
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
