import 'dart:io';

import 'package:anylearn/dto/login_callback.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:validators/validators.dart' as validator;

import '../../blocs/login/login_blocs.dart';
import '../../customs/register_curved_paint.dart';

class LoginForm extends StatefulWidget {
  final LoginCallback callback;
  final LoginBloc loginBloc;

  const LoginForm({Key key, this.callback, this.loginBloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _phoneNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _checking = false;
  AccessToken _accessToken;

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    Map<String, dynamic> deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        print(deviceData);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    return BlocListener<LoginBloc, LoginState>(
      bloc: widget.loginBloc,
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
        if (state is LoginFacebookSuccessState) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Đăng nhập thành công."),
            backgroundColor: Colors.green,
          ));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        bloc: widget.loginBloc,
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
                                Navigator.of(context).popAndPushNamed("/register", arguments: widget.callback);
                              })
                      ]),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent, Colors.blue]),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 48.0,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
                    child: FlatButton.icon(
                      icon: Icon(
                        MdiIcons.facebook,
                        color: Colors.white,
                      ),
                      onPressed: state is! LoginInProgressState
                          ? () async {
                              await _loginFacebook();
                            }
                          : () {},
                      label: state is! LoginInProgressState
                          ? Text(
                              "Đăng nhập bằng Facebook",
                              style: TextStyle(fontSize: 16.0, color: Colors.white),
                            )
                          : CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                    ),
                  ),
                  (Platform.isIOS && double.parse(_deviceData["systemVersion"]) > 12.0)
                      ? Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [Colors.grey, Colors.grey[400], Colors.grey]),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          height: 48.0,
                          margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
                          child: FlatButton.icon(
                            icon: Icon(
                              MdiIcons.apple,
                              color: Colors.white,
                            ),
                            onPressed: state is! LoginInProgressState
                                ? () async {
                                    await _loginApple();
                                  }
                                : () {},
                            label: state is! LoginInProgressState
                                ? Text(
                                    "Đăng nhập bằng Apple",
                                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                                  )
                                : CircularProgressIndicator(
                                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                          ),
                        )
                      : SizedBox(height: 0),
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

  Future<void> _loginApple() async {
    try {
      setState(() {
        _checking = true;
      });
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'vn.anylearn.login',
          redirectUri: Uri.parse(
            'https://api.anylearn.vn/api/',
          ),
        ),
      );
      print(credential);
      if (credential != null) {
        Map<String, String> loginData = {
          "name": credential.givenName + " " + credential.familyName,
          "email": credential.email ?? "",
          "picture": "",
          "id": credential.userIdentifier
        };
        widget.loginBloc..add(LoginAppleEvent(data: loginData));
      }
    } catch (e) {
      print(e.message);
    } finally {
      setState(() {
        _checking = false;
      });
    }
  }

  Future<void> _loginFacebook() async {
    try {
      setState(() {
        _checking = true;
      });
      final LoginResult loginResult = await FacebookAuth.instance.login();

      print(loginResult);
      if (loginResult.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        Map<String, String> loginData = {
          "name": userData['name'],
          "email": userData['email'],
          "picture": userData["picture"]["data"]["url"],
          "id": userData["id"]
        };
        widget.loginBloc..add(LoginFacebookEvent(data: loginData));
      }
    } catch (e) {
      print(e.message);
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          print("You have a previous login operation in progress");
          break;
        case FacebookAuthErrorCode.CANCELLED:
          print("login cancelled");
          break;
        case FacebookAuthErrorCode.FAILED:
          print("login failed");
          break;
      }
    } finally {
      setState(() {
        _checking = false;
      });
    }
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}
