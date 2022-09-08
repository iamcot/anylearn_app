
import 'package:anylearn/themes/default.dart';
import 'package:anylearn/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:validators/validators.dart';

import '../blocs/auth/auth_blocs.dart';

class PasswordupdateScreen extends StatefulWidget {
  const PasswordupdateScreen({Key? key}) : super(key: key);

  @override
  State<PasswordupdateScreen> createState() => _PasswordupdateScreenState();
}

class _PasswordupdateScreenState extends State<PasswordupdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordConfirmController = TextEditingController();
  final _passwordController = TextEditingController();
    final _otpController = TextEditingController();


  late AuthBloc _authBloc;
  bool passwordupdate = false;
  void didChangeDependencies() {
    _authBloc = BlocProvider.of<AuthBloc>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Nhập mật khẩu mới"),
      ),
      body: BlocListener(
         bloc: _authBloc,
        listener: (context, state) {
          if (state is AuthPassResetSuccessState) {
            setState(() {
              passwordupdate = true;
            });
          }
          if (state is AuthPassResetFailState) {
            toast(state.error);
          }
          if (state is AuthPassResetSuccessState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text("Nhập thành công "),
              ));
            Navigator.of(context).pop();
          }
        },

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Nhập mật khẩu mới"),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'Nhập mật khâủ',
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'Nhập lại mật khẩu',
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
            Container(
                  height: 36.0,
                  margin:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                  child: BlocBuilder<AuthBloc, AuthState>(
                      bloc: _authBloc,
                      builder: (context, state) {
                        if (state is AuthPassResetLoadingState ) {
                          return LoadingWidget();
                        }
                        return ElevatedButton(
                            onPressed: () {
                             
                              if (!passwordupdate) {
                                _authBloc
                                  ..add(AuthOTPResetEvent(
                                      otp: _otpController.text));
                              } else {
                                _authBloc
                                  ..add(AuthPassResetEvent(
                                    // phone: _phoneController.text,
                                    // otp: _otp,
                                    // // otp: _otpController.text,
      
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
    );
  }
}
