import 'dart:async';

import 'package:anylearn/widgets/otpform.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:overlay_support/overlay_support.dart';

import '../blocs/auth/auth_blocs.dart';
import '../widgets/loading_widget.dart';
import '../widgets/otpform.dart';

class PasswordResetScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PasswordResetScreen();
}

class _PasswordResetScreen extends State<PasswordResetScreen> {
  int secondsRemaining = 0;
  bool enableResend = false;
  late Timer timer;
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
  // final _resendotp = TextEditingController();
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldfive = TextEditingController();
  final TextEditingController _fieldsix = TextEditingController();
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

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
        title: Text("Nhập mã OTP").tr(),
      ),
      body: BlocListener(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is AuthPassOtpSuccessState) {
            setState(() {
              sentOTP = true;
              // enableResend = false;
              steps = 2;
            });
          }
          if (state is AuthResentOtpSuccessState) {
            setState(() {
              enableResend = true;
            });
          }
          ;
          if (state is AuthResentOtpFailState) {
            toast(state.error);
          }
          ;

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
                    "Thay đổi mật khẩu thành công. Vui lòng đăng nhập lại").tr(),
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
                  sentOTP ? "Nhập OTP từ SMS ".tr() : "Nhập SDT để nhận OTP".tr(),
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
                            return "Bạn quên nhập số điện thoại rồi nè.".tr();
                          }
                          _formKey.currentState!.save();
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Số điện thoại".tr(),
                          icon: Icon(MdiIcons.phone),
                        ),
                      ),
                    )
                  : Container(),
              steps == 2
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
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
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: enableResend ? _resendCode : null,
                          child: enableResend ?  Text('Gửi lại OTP',style: TextStyle(fontSize: 10),).tr()
                          : Text(
                          "Gửi lại sau $secondsRemaining giây",
                          style: TextStyle(color: Colors.blue, fontSize: 10),
                        ).tr(),
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  : Container(),
              steps == 3
                  ? Column(
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 30.0),
                          child: TextFormField(
                            controller: _passwordController,
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
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 30.0),
                          child: TextFormField(
                            controller: _passwordConfirmController,
                            validator: (value) {
                              if (value != _passwordController.text) {
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
                      ],
                    )
                  : Container(),
              SizedBox(height: 10),
              Container(
                height: 36.0,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                child: BlocBuilder<AuthBloc, AuthState>(
                    bloc: _authBloc,
                    builder: (context, state) {
                      if (state is AuthPassOtpLoadingState || state is AuthCheckPhoneOTPLoadingState || state is AuthPassResetLoadingState) {
                        return LoadingWidget();
                      }
                      return ElevatedButton(
                          onPressed: () {
                            if (steps == 1) {
                              _authBloc..add(AuthPassOtpEvent(phone: _phoneController.text));
                            } else if (steps == 2) {
                              setState(() {
                                _otp = _fieldOne.text +
                                    _fieldTwo.text +
                                    _fieldThree.text +
                                    _fieldFour.text +
                                    _fieldfive.text +
                                    _fieldsix.text;
                              });
                              _authBloc..add(AuthCheckOtpEvent(otp: _otp, phone: _phoneController.text));
                            } else if (steps == 3) {
                              _authBloc
                                ..add(AuthPassResetEvent(
                                  phone: _phoneController.text,
                                  otp: _otp,
                                  password: _passwordController.text,
                                  confirmPassword: _passwordConfirmController.text,
                                ));
                            }
                          },
                          child: Text("Gửi").tr());
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _resendCode() {
    //other code here
    setState(() {
      secondsRemaining = 60;
      enableResend = false;
    });
  }

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }
}
